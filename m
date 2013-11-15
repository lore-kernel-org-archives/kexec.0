Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VhSTq-0002BB-Ce
 for kexec@lists.infradead.org; Fri, 15 Nov 2013 23:07:14 +0000
Message-ID: <1384556525.1791.4.camel@misato.fc.hp.com>
Subject: Re: [patch 1/7 v2] Add function efi_remap_region for remapping to
 saved virt address
From: Toshi Kani <toshi.kani@hp.com>
Date: Fri, 15 Nov 2013 16:02:05 -0700
In-Reply-To: <20131105082715.502723229@dhcp-16-126.nay.redhat.com>
References: <20131105082007.872550445@dhcp-16-126.nay.redhat.com>
 <20131105082715.502723229@dhcp-16-126.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: dyoung@redhat.com
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Tue, 2013-11-05 at 16:20 +0800, dyoung@redhat.com wrote:
> Kexec kernel will use saved runtime virtual mapping, so add a
> new function efi_remap_region to remapping it directly without
> calculate the virt addr from efi_va.
> 
> The md is passed in from 1st kernel, the virtual addr is
> saved in md->virt_addr.

 :

> +/*
> + * kexec kernel will use efi_map_region_fixed to map efi
> + * runtime memory ranges. md->virt_addr is the original virtual
> + * address which had been mapped in kexec 1st kernel.
> + */
> +void __init efi_map_region_fixed(efi_memory_desc_t *md)

Can you simply use __map_region() instead of creating this function?
Both functions seem to do the same thing.  (In __map_region(), size and
end are not used.)

Thanks,
-Toshi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
