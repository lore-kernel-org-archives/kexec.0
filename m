Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KZAoH-0007uW-8S
	for kexec@lists.infradead.org; Fri, 29 Aug 2008 20:43:09 +0000
From: "Luck, Tony" <tony.luck@intel.com>
Date: Fri, 29 Aug 2008 13:42:40 -0700
Subject: RE: kdump broken on Altix 350
Message-ID: <57C9024A16AD2D4C97DC78E552063EA30A0067D6@orsmsx505.amr.corp.intel.com>
References: <20080829180302.6e67c26e@halley.suse.de>
	<20080829180531.0524a1e4@halley.suse.de>
In-Reply-To: <20080829180531.0524a1e4@halley.suse.de>
Content-Language: en-US
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: "jlan@sgi.com" <jlan@sgi.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

> your commit
>
>     commit 10617bbe84628eb18ab5f723d3ba35005adde143
>     Author: Tony Luck <tony.luck@intel.com>
>     Date:   Tue Aug 12 10:34:20 2008 -0700
>
>     [IA64] Ensure cpu0 can access per-cpu variables in early boot code
>
> broke kdump on our Altix 350. I get following early crash in kdump
> kernel

Sorry about that.  I'll try to reproduce it here.  Do you (or anyone
else reading this) know if the version of kexec that ships with RHEL5.2
works with current 2.6.27-rc kernels (perhaps not a politically correct
question to ask someone with a @suse.de address :-)

-Tony

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
