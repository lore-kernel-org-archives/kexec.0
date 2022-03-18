From: Coiby Xu <coxu@redhat.com>
Date: Fri, 18 Mar 2022 10:48:03 +0800
Subject: [RESEND PATCH v3 1/3] kexec: clean up arch_kexec_kernel_verify_sig
In-Reply-To: <YjMtb7u3/sAWG0/7@MiWiFi-R3L-srv>
References: <20220304020341.85583-1-coiby.xu@gmail.com>
 <20220304020341.85583-2-coiby.xu@gmail.com>
 <YjMtb7u3/sAWG0/7@MiWiFi-R3L-srv>
Message-ID: <20220318024803.pkkwgknwur2y75mt@Rk>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu, Mar 17, 2022 at 08:45:35PM +0800, Baoquan He wrote:
>On 03/04/22 at 10:03am, Coiby Xu wrote:
>> From: Coiby Xu <coxu@redhat.com>
>>
>> commit 9ec4ecef0af7790551109283ca039a7c52de343c ("kexec_file,x86,
>> powerpc: factor out kexec_file_ops functions" allows implementing
>> the arch-specific implementation of kernel image verification
>> in kexec_file_ops->verify_sig. Currently, there is no arch-specific
>> implementation of arch_kexec_kernel_verify_sig. So clean it up.
>
>This is a nice cleanup, while the log may need to be improved. You
>should run ./scripts/checkpatch.pl on your patch before sending out.
>When we refer to a commit in log, please refer to
>Documentation/process/submitting-patches.rst.

Thanks for the reminder! I've used git pre-commit hook to run 
scripts/checkpatch.pl automatically but obviously this hook doesn't
apply to "git rebase --continue" and currently this no git hook that
for this situation. I'll use the following trick [1] to avoid this
mistake in the future,
  $ git rebase -i HEAD~3 --reschedule-failed-exec --exec "git show | perl ./scripts/checkpatch.pl"

[1] https://stackoverflow.com/a/70568833/1203522


-- 
Best regards,
Coiby


