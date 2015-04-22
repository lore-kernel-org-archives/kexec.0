Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ykkn6-0004iH-NP
 for kexec@lists.infradead.org; Wed, 22 Apr 2015 02:53:33 +0000
Date: Wed, 22 Apr 2015 10:53:05 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH RFC 5/6] arm64: Add support for binary image
Message-ID: <20150422025305.GB4458@dhcp-16-116.nay.redhat.com>
References: <cover.1429201849.git.panand@redhat.com>
 <0a15f2079e6c378996dceda1d509df77d2f43899.1429201849.git.panand@redhat.com>
 <20150420072402.GG15033@dhcp-16-116.nay.redhat.com>
 <5535D522.3080806@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5535D522.3080806@redhat.com>
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
Cc: kexec@lists.infradead.org, kexec@lists.fedoraproject.org

On 04/21/15 at 10:12am, Pratyush Anand wrote:
> 
> 
> On Monday 20 April 2015 12:54 PM, Baoquan He wrote:
> >On 04/16/15 at 10:17pm, Pratyush Anand wrote:
> >>>This patch adds support to use binary image ie arch/arm64/boot/Image.
> >>>
> >>>Binary image does not have sufficient knowledge to extract page offset
> >>>information, which is needed by kexec tool. Use a new command parameter
> >>>--page-offset, so that user can provide page offset information for
> >>>liner mapping.
> >>>
> >>>Signed-off-by: Pratyush Anand<panand@redhat.com>
> >>>---
> >Seems there's a function get_kernel_page_offset used to get page_offset
> >automatically in arm. arm64 should have it either.
> >
> >
> 
> ARM still takes user option for --page-offset in user_page_offset
> variable and then cross check that value with one found in
> /proc/kallsyms.

Well, this looks good. Try --page-offset and then fetch it in
/proc/kallsysms if not specificed by user. ARM64 should have this too.

> 
> May be for ARM64, we can read it like "value of symbol _text in
> /proc/kallsyms & 0xfffffffffff00000".
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
