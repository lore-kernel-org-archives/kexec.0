Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VrQjF-0003DA-Qt
 for kexec@lists.infradead.org; Fri, 13 Dec 2013 11:16:23 +0000
Date: Fri, 13 Dec 2013 15:20:30 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 08/14] efi: export efi runtime memory mapping to sysfs
Message-ID: <20131213072030.GA11164@dhcp-16-126.nay.redhat.com>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <1386582147-9802-9-git-send-email-dyoung@redhat.com>
 <20131211185520.GG23793@pd.tnic>
 <20131212023617.GF3751@dhcp-16-126.nay.redhat.com>
 <20131212071337.GI3751@dhcp-16-126.nay.redhat.com>
 <20131212203656.GC26927@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131212203656.GC26927@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On 12/12/13 at 09:36pm, Borislav Petkov wrote:
> On Thu, Dec 12, 2013 at 03:13:37PM +0800, Dave Young wrote:
> > BTW, I will restructure the whole code when I move them to
> > efi_kexec.c, so no worry about it? If you have strong opinion I can
> > move them though.
> 
> Well, if it were me, I'd do it now so that it'll see more testing.
> Later, it will be only a mechanical move of those functions which belong
> to efi_kexec.c and won't need a second testing.

Will do, thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
