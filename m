Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QqzkP-0005k0-F3
	for kexec@lists.infradead.org; Wed, 10 Aug 2011 03:46:26 +0000
Date: Wed, 10 Aug 2011 12:46:17 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: include minor klibc porting
Message-ID: <20110810034617.GG27303@verge.net.au>
References: <1312828988-3203-1-git-send-email-max@stro.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1312828988-3203-1-git-send-email-max@stro.at>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: maximilian attems <max@stro.at>
Cc: kexec@lists.infradead.org

On Mon, Aug 08, 2011 at 08:43:08PM +0200, maximilian attems wrote:
> These 2 "uncommon" include pathes are the first stumbling blocks
> to build kexec-tools against klibc.
> 
> Of course more is needed, but this is a first step.
> On the klibc step there is still stuff needed, but
> it is already possible with hacks as Oppenembedded shows.
> 
> Signed-off-by: maximilian attems <max@stro.at>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
