Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1P0RA5-0001gU-Jh
	for kexec@lists.infradead.org; Tue, 28 Sep 2010 03:47:26 +0000
Message-ID: <4CA16522.8060107@zytor.com>
Date: Mon, 27 Sep 2010 20:46:42 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: kexec load failure introduced by "x86,
	memblock: Replace e820_/_early string with memblock_"
References: <632974489.2046131285586512527.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<4CA11918.7050708@kernel.org> <4CA11FB7.2080101@zytor.com>
	<4CA126BE.7000609@kernel.org> <4CA1283C.9010105@zytor.com>
	<4CA12976.5060504@kernel.org> <4CA129EB.5000309@zytor.com>
	<4CA12BAB.1040308@kernel.org> <20100928005358.GA6456@redhat.com>
In-Reply-To: <20100928005358.GA6456@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec <kexec@lists.infradead.org>, Ingo Molnar <mingo@elte.hu>, Yinghai Lu <yinghai@kernel.org>, caiqian@redhat.com, linux-kernel@vger.kernel.org

On 09/27/2010 05:53 PM, Vivek Goyal wrote:
> 
> Actually, hardcoding the upper limit to 4G is probably not the best idea.
> Kexec loads the the relocatable binary (purgatory) and I remember that
> one of the generated relocation type was signed 32 bit and allowed max value
> to be 2G only. So IIRC, purgatory code always needed to be loaded below 2G.
> 
> I liked HPA's other idea better of introducing memblock_find_in_range_lowest() 
> so that we search bottom up and not rely on a specific upper limit.
> 

No, it's just another crappy hack which is broken in the same way.  It's
better than open-coding, but it's still a hack.

The Right Thing[TM] to do is for kexec to communicate the topmost
address it wants to this code, so it has both the upper and the lower
boundaries available to it instead of just one.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
