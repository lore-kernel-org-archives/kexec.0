Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WYRVa-0005l4-LR
 for kexec@lists.infradead.org; Fri, 11 Apr 2014 02:48:03 +0000
Date: Fri, 11 Apr 2014 10:47:30 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 09/10] x86: Pass memory range via E820 for kdump
Message-ID: <20140411024730.GH5493@dhcp-16-198.nay.redhat.com>
References: <1397121186-9353-1-git-send-email-chaowang@redhat.com>
 <1397121186-9353-14-git-send-email-chaowang@redhat.com>
 <20140411022831.GG5493@dhcp-16-198.nay.redhat.com>
 <5347554A.4080009@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5347554A.4080009@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: kexec@lists.infradead.org, WANG Chao <chaowang@redhat.com>, horms@verge.net.au, linn@hp.com, trenn@suse.de, vgoyal@redhat.com, ebiederm@xmission.com

On 04/10/14 at 07:36pm, H. Peter Anvin wrote:
> On 04/10/2014 07:28 PM, Dave Young wrote:
> >>  
> >> +static void add_e820_map_from_mr(struct x86_linux_param_header *real_mode,
> >> +			struct e820entry *e820, struct memory_range *range, int nr_range)
> >> +{
> >> +	int i;
> >> +
> >> +	for (i = 0; i < nr_range; i++) {
> >> +		e820[i].addr = range[i].start;
> >> +		e820[i].size = range[i].end - range[i].start;
> > 
> > I see it's same as original code but I still feel it should be end - start + 1;
> > 
> 
> I can't see how it could possibly be +1.
> 
> How do you encode range[].end?  If it is inclusive it should be end -
> start - 1, if it is a semiclosed range (the normal thing in computer
> contexts) then the code above is correct.

Say the first range from my /proc/iomem:
00000000-00000fff : reserved

Shouldn't the size be 0x1000? It looks like closed range instead of semiclosed range.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
