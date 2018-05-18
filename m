Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fJWDQ-0006wH-ER
 for kexec@lists.infradead.org; Fri, 18 May 2018 03:38:02 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1526568530-9144-4-git-send-email-zohar@linux.vnet.ibm.com>
 <74c096ca-1ad1-799e-df3d-7b1b099333a7@schaufler-ca.com>
Date: Thu, 17 May 2018 22:37:23 -0500
In-Reply-To: <74c096ca-1ad1-799e-df3d-7b1b099333a7@schaufler-ca.com> (Casey
 Schaufler's message of "Thu, 17 May 2018 17:24:36 -0700")
Message-ID: <87y3ghhbws.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/9] security: define security_kernel_read_blob()
 wrapper
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
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, "Luis R . Rodriguez" <mcgrof@kernel.org>, Andres Rodriguez <andresx7@gmail.com>, linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>

Casey Schaufler <casey@schaufler-ca.com> writes:

> On 5/17/2018 7:48 AM, Mimi Zohar wrote:
>> In order for LSMs and IMA-appraisal to differentiate between the original
>> and new syscalls (eg. kexec, kernel modules, firmware), both the original
>> and new syscalls must call an LSM hook.
>>
>> Commit 2e72d51b4ac3 ("security: introduce kernel_module_from_file hook")
>> introduced calling security_kernel_module_from_file() in both the original
>> and new syscalls.  Commit a1db74209483 ("module: replace
>> copy_module_from_fd with kernel version") replaced these LSM calls with
>> security_kernel_read_file().
>>
>> Commit e40ba6d56b41 ("firmware: replace call to fw_read_file_contents()
>> with kernel version") and commit b804defe4297  ("kexec: replace call to
>> copy_file_from_fd() with kernel version") replaced their own version of
>> reading a file from the kernel with the generic
>> kernel_read_file_from_path/fd() versions, which call the pre and post
>> security_kernel_read_file LSM hooks.
>>
>> Missing are LSM calls in the original kexec syscall and firmware sysfs
>> fallback method.  From a technical perspective there is no justification
>> for defining a new LSM hook, as the existing security_kernel_read_file()
>> works just fine.  The original syscalls, however, do not read a file, so
>> the security hook name is inappropriate.  Instead of defining a new LSM
>> hook, this patch defines security_kernel_read_blob() as a wrapper for
>> the existing LSM security_kernel_file_read() hook.
>
> What a marvelous opportunity to bikeshed!
>
> I really dislike adding another security_ interface just because
> the name isn't quite right. Especially a wrapper, which is just
> code and execution overhead. Why not change security_kernel_read_file()
> to security_kernel_read_blob() everywhere and be done?

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Nack on this sharing nonsense.  These two interfaces do not share any
code in their implementations other than the if statement to distinguish
between the two cases.

Casey you are wrong.  We need something different here.

Mimi a wrapper does not cut it.   The code is not shared.  Despite using
a single function call today.

If we want comprehensible and maintainable code in the security modules
we need to split these two pieces of functionality apart.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
