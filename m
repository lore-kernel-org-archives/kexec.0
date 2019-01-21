Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-f195.google.com ([209.85.166.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glWQt-0005zJ-GR
 for kexec@lists.infradead.org; Mon, 21 Jan 2019 10:04:12 +0000
Received: by mail-it1-f195.google.com with SMTP id g76so15662637itg.2
 for <kexec@lists.infradead.org>; Mon, 21 Jan 2019 02:03:55 -0800 (PST)
MIME-Version: 1.0
References: <20190121095929.26915-1-kasong@redhat.com>
In-Reply-To: <20190121095929.26915-1-kasong@redhat.com>
From: Kairui Song <kasong@redhat.com>
Date: Mon, 21 Jan 2019 18:03:43 +0800
Message-ID: <CACPcB9c2eJ=Wm8Tb6afgyoAQ5TWuGbuqGXq1i9cN8pRFCwXGrw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] let kexec_file_load use platform keyring to verify
 the kernel image
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
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: jwboyer@fedoraproject.org, Eric Biggers <ebiggers@google.com>, Dave Young <dyoung@redhat.com>, nayna@linux.ibm.com, kexec@lists.infradead.org, jmorris@namei.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity <linux-integrity@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, bauerman@linux.ibm.com, serge@hallyn.com

On Mon, Jan 21, 2019 at 6:00 PM Kairui Song <kasong@redhat.com> wrote:
>
> This patch series adds a .platform_trusted_keys in system_keyring as the
> reference to .platform keyring in integrity subsystem, when platform
> keyring is being initialized it will be updated, so it will be
> accessable for verifying PE signed kernel image.
>
> This patch series let kexec_file_load use platform keyring as fall
> back if it failed to verify the image against secondary keyring,
> so the actually PE signature verify process will use keys provides
> by firmware.
>
> After this patch kexec_file_load will be able to verify a signed PE
> bzImage using keys in platform keyring.
>
> Tested in a VM with locally signed kernel with pesign and imported the
> cert to EFI's MokList variable.
>
> To test this patch series on latest kernel, you need to ensure this commit
> is applied as there is an regression bug in sanity_check_segment_list():
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=993a110319a4a60aadbd02f6defdebe048f7773b
>
> Update from V4:
>   - Drop ifdef in security/integrity/digsig.c to make code clearer
>   - Fix a potential issue, set_platform_trusted_keys should not be
>     called when keyring initialization failed
>
> Update from V3:
>   - Tweak and simplify commit message as suggested by Mimi Zohar
>
> Update from V2:
>   - Use IS_ENABLED in kexec_file_load to judge if platform_trusted_keys
>     should be used for verifying image as suggested by Mimi Zohar
>
> Update from V1:
>   - Make platform_trusted_keys static, and update commit message as suggested
>     by Mimi Zohar
>   - Always check if platform keyring is initialized before use it
>
> Kairui Song (2):
>   integrity, KEYS: add a reference to platform keyring
>   kexec, KEYS: Make use of platform keyring for signature verify
>
>  arch/x86/kernel/kexec-bzimage64.c | 13 ++++++++++---
>  certs/system_keyring.c            | 22 +++++++++++++++++++++-
>  include/keys/system_keyring.h     |  9 +++++++++
>  include/linux/verification.h      |  1 +
>  security/integrity/digsig.c       |  3 +++
>  5 files changed, 44 insertions(+), 4 deletions(-)
>
> --
> 2.20.1
>

Hi Mimi,

I've updated the patch series again and as the code changed a bit I
didn't include previous Reviewd-by / Tested-by, it worked with no
problem, could you help have a review again? Thank you.

-- 
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
