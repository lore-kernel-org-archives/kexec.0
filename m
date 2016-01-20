Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yk0-x243.google.com ([2607:f8b0:4002:c07::243])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aM2ca-0003zG-Nl
 for kexec@lists.infradead.org; Wed, 20 Jan 2016 23:57:05 +0000
Received: by mail-yk0-x243.google.com with SMTP id k129so2030711yke.3
 for <kexec@lists.infradead.org>; Wed, 20 Jan 2016 15:56:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160120233919.GM11277@wotan.suse.de>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-8-git-send-email-zohar@linux.vnet.ibm.com>
 <20160120233919.GM11277@wotan.suse.de>
From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Wed, 20 Jan 2016 15:56:24 -0800
Message-ID: <CAB=NE6Wbx4hY6q2skNp4JQVvfP-eCHxr3rT3h1bq6zuSsoN9+w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/11] firmware: replace call to
 fw_read_file_contents() with kernel version
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mimi Zohar <zohar@linux.vnet.ibm.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Wed, Jan 20, 2016 at 3:39 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> On Mon, Jan 18, 2016 at 10:11:22AM -0500, Mimi Zohar wrote:
>> Replace fw_read_file_contents() for reading a file with the common VFS
>> kernel_read_file() function.  A benefit of calling kernel_read_file()
>> to read the firmware is the firmware is read only once, instead of once
>> for measuring/appraising the firmware and again for reading the file
>> contents into memory.
>>
>> This patch retains the kernel_fw_from_file() hook, which is called from
>> security_kernel_post_read_file(), but removes the
>> sercurity_kernel_fw_from_file() function.
>>
>> Changelog:
>> - reordered and squashed firmware patches
>> - fix MAX firmware size (Kees Cook)
>>
>> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
>> ---
>>  drivers/base/firmware_class.c         | 48 ++++++++++-------------------------
>>  include/linux/ima.h                   |  7 +----
>>  include/linux/security.h              |  8 +-----
>>  security/integrity/ima/ima.h          |  1 -
>>  security/integrity/ima/ima_appraise.c |  8 ------
>>  security/integrity/ima/ima_main.c     | 18 +++++--------
>>  security/integrity/ima/ima_policy.c   | 26 +++++++++----------
>>  security/integrity/integrity.h        | 11 +++-----
>>  security/security.c                   | 28 ++++++++++----------
>>  9 files changed, 54 insertions(+), 101 deletions(-)
>>
>> diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
>> index 8524450..cc175f1 100644
>> --- a/drivers/base/firmware_class.c
>> +++ b/drivers/base/firmware_class.c
>> @@ -29,6 +29,7 @@
>>  #include <linux/syscore_ops.h>
>>  #include <linux/reboot.h>
>>  #include <linux/security.h>
>> +#include <linux/ima.h>
>>
>>  #include <generated/utsrelease.h>
>>
>> @@ -291,40 +292,10 @@ static const char * const fw_path[] = {
>>  module_param_string(path, fw_path_para, sizeof(fw_path_para), 0644);
>>  MODULE_PARM_DESC(path, "customized firmware image search path with a higher priority than default path");
>>
>> -static int fw_read_file_contents(struct file *file, struct firmware_buf *fw_buf)
>> -{
>> -     int size;
>> -     char *buf;
>> -     int rc;
>> -
>> -     if (!S_ISREG(file_inode(file)->i_mode))
>> -             return -EINVAL;
>> -     size = i_size_read(file_inode(file));
>> -     if (size <= 0)
>> -             return -EINVAL;
>> -     buf = vmalloc(size);
>> -     if (!buf)
>> -             return -ENOMEM;
>> -     rc = kernel_read(file, 0, buf, size);
>> -     if (rc != size) {
>> -             if (rc > 0)
>> -                     rc = -EIO;
>> -             goto fail;
>> -     }
>> -     rc = security_kernel_fw_from_file(file, buf, size);
>> -     if (rc)
>> -             goto fail;
>> -     fw_buf->data = buf;
>> -     fw_buf->size = size;
>> -     return 0;
>> -fail:
>> -     vfree(buf);
>> -     return rc;
>> -}
>> -
>>  static int fw_get_filesystem_firmware(struct device *device,
>>                                      struct firmware_buf *buf)
>>  {
>> +     loff_t size;
>>       int i, len;
>>       int rc = -ENOENT;
>>       char *path;
>> @@ -350,13 +321,18 @@ static int fw_get_filesystem_firmware(struct device *device,
>>               file = filp_open(path, O_RDONLY, 0);
>>               if (IS_ERR(file))
>>                       continue;
>> -             rc = fw_read_file_contents(file, buf);
>> +
>> +             buf->size = 0;
>> +             rc = kernel_read_file(file, &buf->data, &size, INT_MAX,
>> +                                   FIRMWARE_CHECK);
>
> The way kernel firmware signing was implemented was that we'd first read the
> foo.sig (or whatever extension we use). The same kernel_read_file() would be
> used if this gets applied so this would still works well with that. Of course
> folks using IMA and their own security policy would just disable the kernel
> fw signing facility.
>
>> diff --git a/include/linux/ima.h b/include/linux/ima.h
>> index ae91938..0a7f039 100644
>> --- a/include/linux/ima.h
>> +++ b/include/linux/ima.h
>> @@ -16,6 +16,7 @@ struct linux_binprm;
>>  enum ima_policy_id {
>>       KEXEC_CHECK = 1,
>>       INITRAMFS_CHECK,
>> +     FIRMWARE_CHECK,
>>       IMA_MAX_READ_CHECK
>>  };
>
> The only thing that is worth questioning here in light of kernel fw signing is
> what int policy_id do we use? Would we be OK to add FIRMWARE_SIG_CHECK later
> While at it, perhaps kernel_read_file() last argument should be enum
> ima_policy_id then. If the policy_id is going to be used elsewhere outside of
> IMA then perhaps ima.h is not the best place for it ? Would fs.h for type of
> file be OK ? Then we'd have a list of known file types the kernel reads.

Actually your patch #9 "ima: load policy using path" defines
kernel_read_file_from_path and since the firmware code uses a path
this code would be much cleaner if instead you used that. It'd mean
more code sharing and would make firmware code cleaner. Could you
re-order that to go first and then later this as its first user?
Perhaps add the helper for the firmware patch.

 Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
