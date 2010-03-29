Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NwN0j-0000q1-NS
	for kexec@lists.infradead.org; Mon, 29 Mar 2010 22:00:46 +0000
Date: Tue, 30 Mar 2010 08:59:56 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: Use the build date for package release
Message-ID: <20100329215956.GI3681@verge.net.au>
References: <ef5c633db9ef8fe23d82ddcfd862bf565435ed45.1269863565.git.ameya.palande@nokia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ef5c633db9ef8fe23d82ddcfd862bf565435ed45.1269863565.git.ameya.palande@nokia.com>
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
To: Ameya Palande <ameya.palande@nokia.com>
Cc: kexec@lists.infradead.org

On Mon, Mar 29, 2010 at 02:52:58PM +0300, Ameya Palande wrote:
> kexec built from git HEAD shows release date as 13th August 2009, which is not
> correct. Instead of that use the build date as release date.

Thanks, applied.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
