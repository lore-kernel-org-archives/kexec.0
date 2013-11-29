Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VmMb8-0005vY-Fo
 for kexec@lists.infradead.org; Fri, 29 Nov 2013 11:51:04 +0000
Date: Fri, 29 Nov 2013 12:50:29 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 06/12] efi: export efi runtime memory mapping to sysfs
Message-ID: <20131129115029.GB4266@pd.tnic>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
 <1385445477-9665-7-git-send-email-dyoung@redhat.com>
 <20131127114402.GB32267@pd.tnic>
 <20131129094034.GI4186@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131129094034.GI4186@dhcp-16-126.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Fri, Nov 29, 2013 at 05:40:35PM +0800, Dave Young wrote:
> Matt are suggesting to below one, is it ok to you? I'm fine with both.
>
> The efi runtime services can only be switched to virtual mode once
> without rebooting. The kexec kernel must maintain the same physical
> to virtual address mappings as the first kernel. The mappings are
> exported to sysfs so userspace tools can reassemble them and pass them
> into the kexec kernel.

His is explaining it better so take his :)

> Is it always 4K, how about "in pages"?

Actually no, so "in pages" is better.

> Since we do not know the exact number of ranges, introducing a list
> or count the totoal range numbers before will add more code. Do you
> really think it's necessary?
>
> I tend to not fix every warnings from checkpatch if it's not a
> must-fix one.

No need for the list - I actually meant you simply use a tmp pointer for
each krealloc invocation - just look around the tree for examples.

Also think about what happens to the pointed-to memory when krealloc
returns NULL.

> suppose kexec runtime map preparing fails we still can get 1st kernel
> boot ok.

Yeah, nothing stops that - especially if you iterate over the mapped
regions a second time separately, for kexec.

Which reminds me, all that save_runtime_map code needs to be behind
CONFIG_KEXEC. We don't want to be doing this if KEXEC is not enabled.

> > What would be much cleaner IMO would be if you let efi_map_regions()
> > finish, *and*, *only* if it was successful iterate again over the
> > regions and do efi_save_runtime_map() on the runtime ones. This will
> > make the code much more readable too.
> 
> For simplifying the code, will do.

Right, and hide it behind CONFIG_KEXEC too, while you're at it.

> I did not add KEXEC because I thought it can be used for debugging
> purpose.

mfleming is thinking about it :)

> Will check and update, what tree are you using?

Always current Linus tree and tip/master. This helps catch issues like
that.

> Hmm, it's created in efi.c so I think we can not move it..

Ok, so we apparently export naked kobjects like that. All right, fair
enough.

...

> Thanks for catching, actually I have changed it in my local tree since
> your last comment about other file.

:)

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
