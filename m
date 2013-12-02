Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VnJPK-00038y-0q
 for kexec@lists.infradead.org; Mon, 02 Dec 2013 02:38:46 +0000
Date: Mon, 2 Dec 2013 10:38:01 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 08/12] efi: only print saved efi runtime maps instead
 of all memmap ranges for kexec
Message-ID: <20131202023801.GC3999@dhcp-16-126.nay.redhat.com>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
 <1385445477-9665-9-git-send-email-dyoung@redhat.com>
 <20131127102701.GD18170@console-pimps.org>
 <20131127142726.GE32267@pd.tnic>
 <20131129085050.GF4186@dhcp-16-126.nay.redhat.com>
 <20131129164736.GE4266@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131129164736.GE4266@pd.tnic>
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
Cc: Matt Fleming <matt@console-pimps.org>, linux-efi@vger.kernel.org, toshi.kani@hp.com, mjg59@srcf.ucam.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On 11/29/13 at 05:47pm, Borislav Petkov wrote:
> On Fri, Nov 29, 2013 at 04:50:50PM +0800, Dave Young wrote:
> > It's for debugging purpose, I think it's helpful.
> 
> Why? The first kernel did dump it already.

As for the efi printk though 1st kernel already printed them out, but kexec kernel
context is diffrent from 1st kernel, it's a fresh reboot we do need reprint them.

I think kexec reboot is just like a normal reboot from user's point of view.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
