Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yk1vJ-00033i-11
 for kexec@lists.infradead.org; Mon, 20 Apr 2015 02:59:01 +0000
Date: Mon, 20 Apr 2015 10:58:28 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH RFC 6/6] arm64: wait for transmit completion before next
 character transmission
Message-ID: <20150420025828.GD15033@dhcp-16-116.nay.redhat.com>
References: <cover.1429201849.git.panand@redhat.com>
 <6c8a63f701e98cb7cf4ddd96ab5b509115ebdc41.1429201849.git.panand@redhat.com>
 <20150417053621.GA8658@dhcp-128-1.nay.redhat.com>
 <55309C29.5050702@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55309C29.5050702@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: Minfei Huang <mhuang@redhat.com>, kexec@lists.infradead.org, kexec@lists.fedoraproject.org

On 04/17/15 at 11:07am, Pratyush Anand wrote:
> 
> 
> On Friday 17 April 2015 11:06 AM, Minfei Huang wrote:
> >>  	.quad	0
> >>>  size arm64_dtb_addr
> >>>+
> >>>+.globl arm64_sink_lsr_val
> >>>+arm64_sink_lsr_val:
> >>>+	.word	0
> >Since arm64_sink_lsr_val is declared as uint32_t, it is better to keep
> >the same format here.

".word" only stores 16bit, doesn't it? Should it be ".int" or ".long"?
You can check gnu as manual for reference.

Thanks
Baoquan

> >
> 
> I thought .word will do the same. But may be I am wrong. What is the
> good syntax for uint32_t.
> 
> ~Pratyush
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
