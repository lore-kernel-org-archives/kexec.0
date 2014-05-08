Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WiMYK-0003WD-0Q
 for kexec@lists.infradead.org; Thu, 08 May 2014 11:31:52 +0000
Date: Thu, 8 May 2014 19:31:27 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH v7 0/9] kexec-tools, x86: E820 memmap pass for kdump
Message-ID: <20140508113127.GA10420@dhcp-17-89.nay.redhat.com>
References: <1398135407-30142-1-git-send-email-chaowang@redhat.com>
 <20140507144551.GC21048@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140507144551.GC21048@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, linn@hp.com, hpa@zytor.com, dyoung@redhat.com, trenn@suse.de

On 05/07/14 at 10:45am, Vivek Goyal wrote:
> Hi Chao,
> 
> I was testing latest kexec-tools and noticed that I still see some
> memmap entries on command line. I think they are ACPI memory and data
> areas.
> 
> memmap=32K#8192K memmap=960K#8256K memmap=96K#2062752K memmap=16K#2062948K
> memmap=32K#2096108K memmap=16K#2096140K
> 
> Is there a reason why ACPI related entries should be passed through
> command line and not through bootparams memory map.

Good catch!

Sorry, I made a mistake in commit 91f5b9c ("kdump: pass e820
reserved region to 2nd kernel via e820 table or setup data").

I've sent a fix:
http://lists.infradead.org/pipermail/kexec/2014-May/011768.html

Please give it try. Thanks in advance.

WANG Chao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
