Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T9GgN-0001RS-2J
 for kexec@lists.infradead.org; Wed, 05 Sep 2012 14:34:21 +0000
From: "Matthew Leach" <matthew.leach@arm.com>
References: <1346845443-32242-1-git-send-email-matthew.leach@arm.com>
 <20120905123850.GA11453@verge.net.au>
In-Reply-To: <20120905123850.GA11453@verge.net.au>
Subject: RE: [RFC PATCH 0/4]  Add device-tree support to kexec-tools for ARM
Date: Wed, 5 Sep 2012 15:34:09 +0100
Message-ID: <000001cd8b73$82e6b4f0$88b41ed0$@leach@arm.com>
MIME-Version: 1.0
Content-Language: en-gb
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
To: 'Simon Horman' <horms@verge.net.au>
Cc: Will Deacon <Will.Deacon@arm.com>, kexec@lists.infradead.org

Hi Simon,

> Hi Matt,
> 
> are you aware that I posted patches to add ARM DT support
> to kexec-tools a few weeks ago?

Ah, I missed that...
 
> I'm not particularly concerned which version goes in,
> but perhaps we can learn from each others efforts.

After looking over your patches I propose that I incorporate your
generic fs2dt code instead of pulling in the dtc. Also, I use a
different segment for the dtb rather than appending it to the
zImage; I think this approach would be better as it is less
restrictive, however a kernel patch is required to set r2 to the
appropriate address on entry to the new kernel. What are your
thoughts?

If you are happy with this I will submit a v2 set of patches.

Matt



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
