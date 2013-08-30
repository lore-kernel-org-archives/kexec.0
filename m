Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VFO8i-00060x-UY
 for kexec@lists.infradead.org; Fri, 30 Aug 2013 12:49:26 +0000
Date: Fri, 30 Aug 2013 08:48:54 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/2] x86, apic: Disable BSP if boot cpu is AP
Message-ID: <20130830124854.GA18156@redhat.com>
References: <20130829092458.5476.10277.stgit@localhost6.localdomain6>
 <521F5297.4070906@linux.intel.com> <8738ps131z.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8738ps131z.fsf@xmission.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, akpm@linux-foundation.org, "H. Peter Anvin" <hpa@linux.intel.com>, jingbai.ma@hp.com

On Thu, Aug 29, 2013 at 04:37:44PM -0700, Eric W. Biederman wrote:

[..]
> This situation is people who run machines of unreasonable size really
> would like to use multiple cpus when generating crash dumps.

Yes. Now kdump is in a phase where people are doing scalability work. And
one of the problems is that on mutli tera byte machines, filtering is
taking long time. With-in filtering it is especially the compression which
takes the longest (hatayama and cliff wickman have done some study here).

So Idea seems to be that bring up more cpus in the second kernel and try
to parallelize compression work and try to save dump time of multi tera
byte machines.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
