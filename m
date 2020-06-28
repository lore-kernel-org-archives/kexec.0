Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from linux.microsoft.com ([13.77.154.182])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpKn3-0001DR-6f
 for kexec@lists.infradead.org; Sun, 28 Jun 2020 00:03:22 +0000
Subject: Re: [PATCH v2 11/11] ima: Support additional conditionals in the
 KEXEC_CMDLINE hook function
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
 <20200626223900.253615-12-tyhicks@linux.microsoft.com>
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <f8897c9a-2ee4-c42b-3138-15ea9d14852c@linux.microsoft.com>
Date: Sat, 27 Jun 2020 17:03:11 -0700
MIME-Version: 1.0
In-Reply-To: <20200626223900.253615-12-tyhicks@linux.microsoft.com>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Tyler Hicks <tyhicks@linux.microsoft.com>, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Prakhar Srivastava <prsriva02@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, linux-integrity@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>

On 6/26/20 3:39 PM, Tyler Hicks wrote:
> Take the properties of the kexec kernel's inode and the current task
> ownership into consideration when matching a KEXEC_CMDLINE operation to
> the rules in the IMA policy. This allows for some uniformity when
> writing IMA policy rules for KEXEC_KERNEL_CHECK, KEXEC_INITRAMFS_CHECK,
> and KEXEC_CMDLINE operations.
> 
> Prior to this patch, it was not possible to write a set of rules like
> this:
> 
>   dont_measure func=KEXEC_KERNEL_CHECK obj_type=foo_t
>   dont_measure func=KEXEC_INITRAMFS_CHECK obj_type=foo_t
>   dont_measure func=KEXEC_CMDLINE obj_type=foo_t
>   measure func=KEXEC_KERNEL_CHECK
>   measure func=KEXEC_INITRAMFS_CHECK
>   measure func=KEXEC_CMDLINE
> 
> The inode information associated with the kernel being loaded by a
> kexec_kernel_load(2) syscall can now be included in the decision to
> measure or not
> 
> Additonally, the uid, euid, and subj_* conditionals can also now be
> used in KEXEC_CMDLINE rules. There was no technical reason as to why
> those conditionals weren't being considered previously other than
> ima_match_rules() didn't have a valid inode to use so it immediately
> bailed out for KEXEC_CMDLINE operations rather than going through the
> full list of conditional comparisons.
> 
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: kexec@lists.infradead.org
> ---
> 
> * v2
>    - Moved the inode parameter of process_buffer_measurement() to be the
>      first parameter so that it more closely matches process_masurement()
> 
>   include/linux/ima.h                          |  4 ++--
>   kernel/kexec_file.c                          |  2 +-
>   security/integrity/ima/ima.h                 |  2 +-
>   security/integrity/ima/ima_api.c             |  2 +-
>   security/integrity/ima/ima_appraise.c        |  2 +-
>   security/integrity/ima/ima_asymmetric_keys.c |  2 +-
>   security/integrity/ima/ima_main.c            | 23 +++++++++++++++-----
>   security/integrity/ima/ima_policy.c          | 17 +++++----------
>   security/integrity/ima/ima_queue_keys.c      |  2 +-
>   9 files changed, 31 insertions(+), 25 deletions(-)
> 

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
