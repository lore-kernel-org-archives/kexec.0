Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jdt6k-0001TG-I5
 for kexec@lists.infradead.org; Wed, 27 May 2020 10:16:24 +0000
Date: Wed, 27 May 2020 12:16:18 +0200
From: Jiri Bohac <jbohac@suse.cz>
Subject: Re: [PATCH] kexec: Do not verify the signature without the lockdown
 or mandatory signature
Message-ID: <20200527101618.jgbxbk5ooiaett43@dwarf.suse.cz>
References: <20200525052351.24134-1-lijiang@redhat.com>
 <20200526135935.ffkfulsjf7xrep63@dwarf.suse.cz>
 <07a65a70-3764-f62f-705c-049b8d409316@redhat.com>
 <4da44e94-a839-2033-29d2-90bebd4ee1e2@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4da44e94-a839-2033-29d2-90bebd4ee1e2@redhat.com>
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
To: lijiang <lijiang@redhat.com>
Cc: bhe@redhat.com, kexec@lists.infradead.org, jmorris@namei.org, mjg59@google.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, dyoung@redhat.com

On Wed, May 27, 2020 at 12:08:12PM +0800, lijiang wrote:
> Or the following change looks better? What's your opinion?
> 
> static int
> kimage_validate_signature(struct kimage *image)
> {
>         int ret;
> 
>         ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
>                                            image->kernel_buf_len);
>         if (ret) {
> 
>                 if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
>                         pr_notice("Enforced kernel signature verification failed (%d).\n", ret);
>                         return ret;
>                 }
> 
>                 /*
>                  * If IMA is guaranteed to appraise a signature on the kexec
>                  * image, permit it even if the kernel is otherwise locked
>                  * down.
>                  */
>                 if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
>                     security_locked_down(LOCKDOWN_KEXEC))
>                         return -EPERM;
> 
>                 pr_debug("kernel signature verification failed (%d).\n", ret);
>         }
> 
>         return 0;
> }

Looks good to me, thanks!

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
