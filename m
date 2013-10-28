Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VaktT-0002LV-O6
 for kexec@lists.infradead.org; Mon, 28 Oct 2013 11:22:00 +0000
Date: Mon, 28 Oct 2013 19:21:21 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 4/4] Passing efi related data via setup_data
Message-ID: <20131028112121.GC29133@dhcp-16-126.nay.redhat.com>
References: <20131027040437.600278368@dhcp-16-126.nay.redhat.com>
 <20131027041231.350640917@dhcp-16-126.nay.redhat.com>
 <526E3F43.8050408@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <526E3F43.8050408@zytor.com>
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
Cc: mjg59@srcf.ucam.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, kexec@lists.fedoraproject.org, ebiederm@xmission.com, bp@alien8.de, vgoyal@redhat.com

On 10/28/13 at 03:41am, H. Peter Anvin wrote:
> On 10/26/2013 09:04 PM, dyoung@redhat.com wrote:
> 
> > +        __uint64_t next;
> 
> WTF is __uint64_t?

bits/types.h:typedef unsigned long int __uint64_t;

I meant to use uint64_t instead of __unit64_t

Will fix.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
