From: Baoquan He <bhe@redhat.com>
Date: Fri, 18 Mar 2022 11:27:09 +0800
Subject: [RESEND PATCH v3 1/3] kexec: clean up arch_kexec_kernel_verify_sig
In-Reply-To: <20220318024803.pkkwgknwur2y75mt@Rk>
References: <20220304020341.85583-1-coiby.xu@gmail.com>
 <20220304020341.85583-2-coiby.xu@gmail.com>
 <YjMtb7u3/sAWG0/7@MiWiFi-R3L-srv>
 <20220318024803.pkkwgknwur2y75mt@Rk>
Message-ID: <YjP8DTnAZbq646rF@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 03/18/22 at 10:48am, Coiby Xu wrote:
> On Thu, Mar 17, 2022 at 08:45:35PM +0800, Baoquan He wrote:
> > On 03/04/22 at 10:03am, Coiby Xu wrote:
> > > From: Coiby Xu <coxu@redhat.com>
> > > 
> > > commit 9ec4ecef0af7790551109283ca039a7c52de343c ("kexec_file,x86,
> > > powerpc: factor out kexec_file_ops functions" allows implementing
> > > the arch-specific implementation of kernel image verification
> > > in kexec_file_ops->verify_sig. Currently, there is no arch-specific
> > > implementation of arch_kexec_kernel_verify_sig. So clean it up.
> > 
> > This is a nice cleanup, while the log may need to be improved. You
> > should run ./scripts/checkpatch.pl on your patch before sending out.
> > When we refer to a commit in log, please refer to
> > Documentation/process/submitting-patches.rst.
> 
> Thanks for the reminder! I've used git pre-commit hook to run
> scripts/checkpatch.pl automatically but obviously this hook doesn't
> apply to "git rebase --continue" and currently this no git hook that
> for this situation. I'll use the following trick [1] to avoid this
> mistake in the future,
>  $ git rebase -i HEAD~3 --reschedule-failed-exec --exec "git show | perl ./scripts/checkpatch.pl"

Sorry, Coiby. It could be late yesterday so I was dizzy when writing
down the comment, I didn't make my concern clear. What I meant is
the referenced commit in log should be taken in a standard format.
Abstracted one paragraph of Documentation/process/submitting-patches.rst
here. We usually take the first 12 characters of the commit SHA-1 ID
in log, but not the whole of them.

=====
If you want to refer to a specific commit, don't just refer to the
SHA-1 ID of the commit. Please also include the oneline summary of
the commit, to make it easier for reviewers to know what it is about.
Example::

        Commit e21d2170f36602ae2708 ("video: remove unnecessary
        platform_set_drvdata()") removed the unnecessary
        platform_set_drvdata(), but left the variable "dev" unused,
        delete it.
=====

And the right parenthesis enclousing the commit subject is missing.

> 
> [1] https://stackoverflow.com/a/70568833/1203522
> 
> 
> -- 
> Best regards,
> Coiby
> 


