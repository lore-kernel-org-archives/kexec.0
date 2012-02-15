Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2402:b800:7003:1:1::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RxWO5-000761-Tg
 for kexec@lists.infradead.org; Wed, 15 Feb 2012 04:22:38 +0000
Date: Wed, 15 Feb 2012 15:16:09 +1100
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH v6 00/10] fadump: Firmware-assisted dump support for
 Powerpc.
Message-ID: <20120215041608.GA15258@bloggs.ozlabs.ibm.com>
References: <20111210064301.10195.3344.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111210064301.10195.3344.stgit@mars.in.ibm.com>
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
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Amerigo Wang <amwang@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kexec-ml <kexec@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Randy Dunlap <rdunlap@xenotime.net>, Anton Blanchard <anton@samba.org>, Vivek Goyal <vgoyal@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

On Sat, Dec 10, 2011 at 12:19:59PM +0530, Mahesh J Salgaonkar wrote:

> The most of the code implementation has been adapted from phyp assisted dump
> implementation written by Linas Vepstas and Manish Ahuja.

When you repost the series, please be explicit about what the
relationship between the new fadump facility and the old phyp-dump
is, both in the documentation you're adding and in the patch
descriptions.

I gather that fadump uses the same firmware interfaces as phyp-dump,
and can be characterised as a rewrite of phyp-dump.  It would be good
if you would explicitly mention:

- What advantages fadump has over phyp-dump
- Whether there are any capabilities that phyp-dump does that fadump
  doesn't
- What is different between fadump and phyp-dump in the interface to
  usermode code
- Any user-visible differences between how fadump operates compared to
  phyp-dump.  For example, will users see a difference in how much
  memory is available to the kernel?

Paul.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
