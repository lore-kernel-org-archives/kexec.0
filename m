Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MoXKR-00044b-Q4
	for kexec@lists.infradead.org; Fri, 18 Sep 2009 06:52:28 +0000
Date: Fri, 18 Sep 2009 16:52:20 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: The failure of the KEXEC on ARM1136
Message-ID: <20090918065220.GA17940@verge.net.au>
References: <E99B4DCB8B5A0241832DBF4FCB7C813A7D0280@zch01exm27.fsl.freescale.net>
	<20090916035131.GO24467@verge.net.au>
	<E99B4DCB8B5A0241832DBF4FCB7C813A7D05A5@zch01exm27.fsl.freescale.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E99B4DCB8B5A0241832DBF4FCB7C813A7D05A5@zch01exm27.fsl.freescale.net>
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
To: Lai Weilin-B04597 <B04597@freescale.com>
Cc: kexec@lists.infradead.org

On Fri, Sep 18, 2009 at 02:01:10PM +0800, Lai Weilin-B04597 wrote:
> Hi Simon,
> I am trying to get kexec working on an ARM1136 using the 2.0.1 version of the KEXEC.
> 
> The loading seems to work ok. On "kexec -e", I see:
> 
> Starting new kernel
> Uncompressing Linux...................................................................................................
> 
> crc error
> 
>  -- System halted
> 
> Have you ever seen this kind of failure ? 

Not that I recall. The only ARM hardware I have is a Treo (i can check the
model when I get home). Would it be worth me trying to reproduce it on that hw?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
