Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QEzTo-0000TF-0N
	for kexec@lists.infradead.org; Wed, 27 Apr 2011 07:48:12 +0000
Date: Wed, 27 Apr 2011 16:48:05 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Fix memory access errors for kexec PPC
Message-ID: <20110427074804.GA8738@verge.net.au>
References: <4DAEA812.4050901@in.ibm.com> <20110427061720.GG14497@verge.net.au>
	<4DB7BA53.6040602@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4DB7BA53.6040602@in.ibm.com>
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
To: Suzuki Poulose <suzuki@in.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Wed, Apr 27, 2011 at 12:10:19PM +0530, Suzuki Poulose wrote:
> On 04/27/11 11:47, Simon Horman wrote:
> >On Wed, Apr 20, 2011 at 03:02:02PM +0530, Suzuki Poulose wrote:
> >>Hi,
> >>
> >>I was trying the kexec for ppc32 and came across a couple of memory errors
> >>while running with glibc.
> >>
> >>The attached patch is the outcome of the glibc's alerts !
> >>We define buf[MAXBYTES-1] and issue  fread(buf, 1, MAXBYTES, file), which glibc
> >>reports an error.
> >>
> >>Also there is a typo in the realloc_memory_ranges() code for ppc which causes in
> >>a double free().
> >
> >Thanks,
> >
> >could you please make this a formal submission by
> >supplying a Signed-off-by line?
> I have updated the patch to use realloc instead of malloc() for memory_range.

Hi,

unfortuantely this doesn't seep to apply to the current git tree.
Could you fix that?

The tree is available at
git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
