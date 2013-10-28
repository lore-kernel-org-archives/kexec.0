Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VabU4-0000FE-O5
 for kexec@lists.infradead.org; Mon, 28 Oct 2013 01:19:09 +0000
Date: Mon, 28 Oct 2013 09:18:24 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 2/6] x86 efi: reserve boot service fix
Message-ID: <20131028011824.GD4397@dhcp-16-126.nay.redhat.com>
References: <20131027034713.481920209@dhcp-16-126.nay.redhat.com>
 <20131027035922.924386710@dhcp-16-126.nay.redhat.com>
 <20131027105009.GA21868@pd.tnic>
 <20131027203058.GE1982@console-pimps.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131027203058.GE1982@console-pimps.org>
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
To: Matt Fleming <matt@console-pimps.org>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, Borislav Petkov <bp@alien8.de>, ebiederm@xmission.com, hpa@zytor.com, kexec@lists.fedoraproject.org, vgoyal@redhat.com

On 10/27/13 at 08:30pm, Matt Fleming wrote:
> On Sun, 27 Oct, at 11:50:09AM, Borislav Petkov wrote:
> > On Sun, Oct 27, 2013 at 11:47:15AM +0800, dyoung@redhat.com wrote:
> > > Current code check boot service region with kernel text region by: 
> > > start+size >= __pa_symbol(_text)
> > > The end of the above region should be start + size - 1 instead.
> > > 
> > > I see this problem in ovmf + Fedora 19 grub boot:
> > > text start: 1000000 md start: 800000 md size: 800000
> > > 
> > > Signed-off-by: Dave Young <dyoung@redhat.com>
> > 
> > Acked-by: Borislav Petkov <bp@suse.de>
> > 
> > Btw, Matt, this being a bugfix and all, shouldn't it be tagged for
> > stable?
> 
> Well that depends. Dave, am I correct in thinking that you only noticed
> this bug when writing kexec support? I'm inclined not to bother with a
> stable tag if no one has ever noticed any fallout from this bug until
> now.

There should be some people see below message with non-kexec kernel:
"Could not reserve boot range ..."
But it's hard for them to notice the bad functionality because it's only
one mem range which might be not the boot range what SetVirtualAddressMap need

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
