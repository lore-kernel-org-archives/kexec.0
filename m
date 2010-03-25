Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.nokia.com ([192.100.122.233] helo=mgw-mx06.nokia.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NulBv-0007Op-FV
	for kexec@lists.infradead.org; Thu, 25 Mar 2010 11:25:40 +0000
Subject: Re: [PATCH] kexec-tools: Fix unused return value warning for fread
From: Ameya Palande <ameya.palande@nokia.com>
In-Reply-To: <20100324113118.GI10098@verge.net.au>
References: <78968d16b4ea65b185019732d0af5888ef070358.1269006846.git.ameya.palande@nokia.com>
	<20100324113118.GI10098@verge.net.au>
Date: Thu, 25 Mar 2010 13:23:53 +0200
Message-ID: <1269516233.2121.3.camel@sanganak>
Mime-Version: 1.0
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
To: ext Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Wed, 2010-03-24 at 12:31 +0100, ext Simon Horman wrote:
> On Fri, Mar 19, 2010 at 03:55:04PM +0200, Ameya Palande wrote:
> > From: Ameya Palande <ameya.palande@nokia.com>
> > 
> > Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> 
> Thanks, applied.
> 
> BTW, which gcc and CFLAGS were you using to see that warning?
> 

I guess -Werror and gcc > 4 (I don't know exact version since I was
compiling it for arm on a build server).

Cheers,
Ameya.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
