Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1IsPyw-0003R3-BB
	for kexec@lists.infradead.org; Wed, 14 Nov 2007 16:41:17 -0500
Date: Wed, 14 Nov 2007 13:40:49 -0800
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Fix the feature determining ELF32/ELF64 automatically
Message-ID: <20071114214044.GD2368@verge.net.au>
References: <47397DBC.8080308@mxs.nes.nec.co.jp>
MIME-Version: 1.0
In-Reply-To: <47397DBC.8080308@mxs.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0147215963=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec-ml <kexec@lists.infradead.org>

--===============0147215963==
Content-Type: text/plain; charset=iso-2022-jp
Content-Disposition: inline

On Tue, Nov 13, 2007 at 07:34:36PM +0900, Ken'ichi Ohmichi wrote:
> 
> Hi,
> 
> This patch fixes the problem that the kexec command cannot determine
> ELF32/ELF64 automatically.
> 
> On i386 system, the kexec command always determined an ELF32 /proc/vmcore
> even if the memory is 4GB or larger, because of referring the outside
> of the array "range[]".

Thanks, applied.

-- 
宝曼 西門 (ホウマン・サイモン) | Simon Horman (Horms)


--===============0147215963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0147215963==--
