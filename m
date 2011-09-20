Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp-out.google.com ([216.239.44.51])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R69If-0007Dv-6U
	for kexec@lists.infradead.org; Tue, 20 Sep 2011 23:00:26 +0000
Date: Tue, 20 Sep 2011 16:00:12 -0700
From: Andrew Morton <akpm@google.com>
Subject: Re: [patch 0/2] kdump: Initialize vmcoreinfo note at startup
Message-Id: <20110920160012.53b941a7.akpm@google.com>
In-Reply-To: <20110920143400.776127689@linux.vnet.ibm.com>
References: <20110920143400.776127689@linux.vnet.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, schwidefsky@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, vgoyal@redhat.com

On Tue, 20 Sep 2011 16:34:00 +0200
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> Hello Andrew,
> 
> Another common code patch that we would like to have upstream is the vmcoreinfo
> note initialization at Linux startup time. We need that for our traditional
> stand-alone and hypervisor dump tools.
> 
> [1] kdump: Initialize vmcoreinfo note at startup
> [2] s390: Export vmcoreinfo note
> 
> I already have discussed this with Vivek and he has acked the common code
> patch [1].
> 
> Do you agree that Martin sends these patches together with the kdump page
> table patches (see https://lkml.org/lkml/2011/9/15/55) in the next merge
> window?

Sounds good to me, thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
