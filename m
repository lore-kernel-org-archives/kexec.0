Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from sg2ehsobe004.messaging.microsoft.com ([207.46.51.78]
	helo=SG2EHSOBE004.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MIrhf-0005wr-12
	for kexec@lists.infradead.org; Mon, 22 Jun 2009 22:09:44 +0000
Message-ID: <4A4000EA.8020907@am.sony.com>
Date: Mon, 22 Jun 2009 15:08:42 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: Re: kexec trouble with gcc-4.3
References: <49D506BB.9030409@am.sony.com>
In-Reply-To: <49D506BB.9030409@am.sony.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: cbe-oss-dev@ozlabs.org

On 04/02/2009 11:40 AM, Geoff Levand wrote:
> Hi,
> 
> I tried building kexec with gcc-4.3 from the cell sdk-3.1
> and the resulting binary didn't work correctly.  It works
> OK with the gcc-4.1 from the same (sdk-3.1).
> 
> Here is the last thing seen, then the system hangs:
> 
> Starting new kernel
> kexec: waiting for cpu 1 (physical 1) to go down
> Invalid tag 26 scanning flattened device tree !
> Invalid tag 26 scanning flattened device tree !
> Invalid tag 26 scanning flattened device tree !
> 
> Does anyone have any ideas?

I finally got around to investigating this, and now
I can't reproduce it.  I tried with 2.6.29 and the
current mainline kernel.  I can only guess it was
something about the kernel at the time.  

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
