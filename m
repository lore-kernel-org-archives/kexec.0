From: Coiby Xu <coxu@redhat.com>
Date: Fri, 18 Mar 2022 17:43:20 +0800
Subject: [RESEND PATCH v3 1/3] kexec: clean up arch_kexec_kernel_verify_sig
In-Reply-To: <YjRIqdAH2nV+DRgW@MiWiFi-R3L-srv>
References: <20220304020341.85583-1-coiby.xu@gmail.com>
 <20220304020341.85583-2-coiby.xu@gmail.com>
 <YjMtb7u3/sAWG0/7@MiWiFi-R3L-srv>
 <20220318024803.pkkwgknwur2y75mt@Rk>
 <YjP8DTnAZbq646rF@MiWiFi-R3L-srv>
 <20220318071824.yq3idr5eoogvtslb@Rk>
 <YjRIqdAH2nV+DRgW@MiWiFi-R3L-srv>
Message-ID: <20220318094320.aoia7yahtmy2hksp@Rk>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, Mar 18, 2022 at 04:54:01PM +0800, Baoquan He wrote:
[...]
>> Btw, checkpatch.pl seems to requires referring to a specific commit on
>> the same line,
>>
>>     ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 9ec4ecef0af7 ("kexec_file,x86,powerpc: factor out kexec_file_ops functions")'
>>     #6:     commit 9ec4ecef0af7 ("kexec_file,x86, powerpc: factor out
>> kexec_file_ops
>>     functions") allows implementing the arch-specific implementation of kernel
>>     total: 1 errors, 0 warnings, 61 lines checked
>>     NOTE: For some of the reported defects, checkpatch may be able to
>>           mechanically convert to the typical style using --fix or --fix-inplace.
>>     "[PATCH] kexec: clean up arch_kexec_kernel_verify_sig" has style problems, please review.
>>     NOTE: If any of the errors are false positives, please report
>>           them to the maintainer, see CHECKPATCH in MAINTAINERS.
>>
>> Is this a false positive?
>
>No, it's not. Youp probably copied the commit subject and modified it.
>Please copy below two lines into your patch to replace and try again.
>
>commit 9ec4ecef0af7 ("kexec_file,x86,powerpc: factor out kexec_file_ops
>functions")

Yes, you are right. I unintentionally changed the subject. I've sent 
v4 to fix this commit reference issue and other checkpatch.pl warnings.
Thanks!

-- 
Best regards,
Coiby


