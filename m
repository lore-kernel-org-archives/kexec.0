Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HlIrB-0001z2-S5
	for kexec@lists.infradead.org; Tue, 08 May 2007 02:07:31 -0400
Date: Tue, 8 May 2007 15:07:19 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch 2/5] kexec improve build for ppc64
Message-ID: <20070508060717.GB8170@verge.net.au>
References: <20070507235727.631477448@am.sony.com>>
	<463FBE2C.6070804@am.sony.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <463FBE2C.6070804@am.sony.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: kexec@lists.infradead.org

On Mon, May 07, 2007 at 05:02:52PM -0700, Geoff Levand wrote:
> Powerpc 64 bit platforms support both 64 bit and 32 bit runtimes.  Allow
> ARCH= to be specified on the command line to separate the processor arch
> from the compiler machine.  This also helps cross-builds with non-standard
> compiler names.

Hi Geoff,

This does fundamentally change the affect that ARCH has on the
build - that is, it now has an affect. And this worries me in
the context of cross-compiling. However, after reasonably extensive
testing of all the supported architectures, I have convinced myself
that it at least for cross-compiling its ok :-)

I have gone ahead and applied this change. But if people
could test building various architectures, I would appreciate it.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
