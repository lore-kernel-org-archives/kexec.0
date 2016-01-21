Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aME1F-0003xd-Mw
 for kexec@lists.infradead.org; Thu, 21 Jan 2016 12:07:18 +0000
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 21 Jan 2016 22:06:54 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 020442CE8056
 for <kexec@lists.infradead.org>; Thu, 21 Jan 2016 23:06:52 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0LC6Yks24510594
 for <kexec@lists.infradead.org>; Thu, 21 Jan 2016 23:06:42 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0LC6JIX019708
 for <kexec@lists.infradead.org>; Thu, 21 Jan 2016 23:06:19 +1100
Message-ID: <1453377959.9549.84.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 07/11] firmware: replace call to
 fw_read_file_contents() with kernel version
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 21 Jan 2016 07:05:59 -0500
In-Reply-To: <CAB=NE6Wbx4hY6q2skNp4JQVvfP-eCHxr3rT3h1bq6zuSsoN9+w@mail.gmail.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1453129886-20192-8-git-send-email-zohar@linux.vnet.ibm.com>
 <20160120233919.GM11277@wotan.suse.de>
 <CAB=NE6Wbx4hY6q2skNp4JQVvfP-eCHxr3rT3h1bq6zuSsoN9+w@mail.gmail.com>
Mime-Version: 1.0
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
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Wed, 2016-01-20 at 15:56 -0800, Luis R. Rodriguez wrote:
> On Wed, Jan 20, 2016 at 3:39 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:

> >> @@ -350,13 +321,18 @@ static int fw_get_filesystem_firmware(struct device *device,
> >>               file = filp_open(path, O_RDONLY, 0);
> >>               if (IS_ERR(file))
> >>                       continue;
> >> -             rc = fw_read_file_contents(file, buf);
> >> +
> >> +             buf->size = 0;
> >> +             rc = kernel_read_file(file, &buf->data, &size, INT_MAX,
> >> +                                   FIRMWARE_CHECK);
> >
> > The way kernel firmware signing was implemented was that we'd first read the
> > foo.sig (or whatever extension we use). 

Was there a reason for using a detached signature and not using the same
method as kernel modules?

> The same kernel_read_file() would be
> > used if this gets applied so this would still works well with that. Of course
> > folks using IMA and their own security policy would just disable the kernel
> > fw signing facility.

Right, support for not measuring/appraising the firmware and sig would
be supported in the policy.

> >> diff --git a/include/linux/ima.h b/include/linux/ima.h
> >> index ae91938..0a7f039 100644
> >> --- a/include/linux/ima.h
> >> +++ b/include/linux/ima.h
> >> @@ -16,6 +16,7 @@ struct linux_binprm;
> >>  enum ima_policy_id {
> >>       KEXEC_CHECK = 1,
> >>       INITRAMFS_CHECK,
> >> +     FIRMWARE_CHECK,
> >>       IMA_MAX_READ_CHECK
> >>  };
> >
> > The only thing that is worth questioning here in light of kernel fw signing is
> > what int policy_id do we use? Would we be OK to add FIRMWARE_SIG_CHECK later
> > While at it, perhaps kernel_read_file() last argument should be enum
> > ima_policy_id then. If the policy_id is going to be used elsewhere outside of
> > IMA then perhaps ima.h is not the best place for it ? Would fs.h for type of
> > file be OK ? Then we'd have a list of known file types the kernel reads.

I would definitely prefer the enumeration be defined at the VFS layer.
For example, 

enum kernel_read_file_id {
        READING_KEXEC_IMAGE,
        READING_KEXEC_INITRAMFS,
        READING_FIRMWARE,
        READING_FIRMWARE_SIG,
        READING_MAX_ID
};

Agreed, the last field of kernel_read_file() and the wrappers should be
the enumeration. 

> Actually your patch #9 "ima: load policy using path" defines
> kernel_read_file_from_path and since the firmware code uses a path
> this code would be much cleaner if instead you used that. It'd mean
> more code sharing and would make firmware code cleaner. Could you
> re-order that to go first and then later this as its first user?
> Perhaps add the helper for the firmware patch.

Thanks, I missed that.  I'll include this change in the next version.

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
