Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from arkanian.console-pimps.org ([212.110.184.194])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VaWzh-00058o-SV
 for kexec@lists.infradead.org; Sun, 27 Oct 2013 20:31:30 +0000
Date: Sun, 27 Oct 2013 20:30:58 +0000
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [patch 2/6] x86 efi: reserve boot service fix
Message-ID: <20131027203058.GE1982@console-pimps.org>
References: <20131027034713.481920209@dhcp-16-126.nay.redhat.com>
 <20131027035922.924386710@dhcp-16-126.nay.redhat.com>
 <20131027105009.GA21868@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131027105009.GA21868@pd.tnic>
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
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, kexec@lists.fedoraproject.org, ebiederm@xmission.com, hpa@zytor.com, dyoung@redhat.com, vgoyal@redhat.com

On Sun, 27 Oct, at 11:50:09AM, Borislav Petkov wrote:
> On Sun, Oct 27, 2013 at 11:47:15AM +0800, dyoung@redhat.com wrote:
> > Current code check boot service region with kernel text region by: 
> > start+size >= __pa_symbol(_text)
> > The end of the above region should be start + size - 1 instead.
> > 
> > I see this problem in ovmf + Fedora 19 grub boot:
> > text start: 1000000 md start: 800000 md size: 800000
> > 
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> 
> Acked-by: Borislav Petkov <bp@suse.de>
> 
> Btw, Matt, this being a bugfix and all, shouldn't it be tagged for
> stable?

Well that depends. Dave, am I correct in thinking that you only noticed
this bug when writing kexec support? I'm inclined not to bother with a
stable tag if no one has ever noticed any fallout from this bug until
now.

-- 
Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
