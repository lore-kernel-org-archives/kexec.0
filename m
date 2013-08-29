Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mga01.intel.com ([192.55.52.88])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VF2gX-0004eS-25
 for kexec@lists.infradead.org; Thu, 29 Aug 2013 13:54:53 +0000
Message-ID: <521F5297.4070906@linux.intel.com>
Date: Thu, 29 Aug 2013 06:54:31 -0700
From: "H. Peter Anvin" <hpa@linux.intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] x86, apic: Disable BSP if boot cpu is AP
References: <20130829092458.5476.10277.stgit@localhost6.localdomain6>
In-Reply-To: <20130829092458.5476.10277.stgit@localhost6.localdomain6>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, ebiederm@xmission.com, akpm@linux-foundation.org, jingbai.ma@hp.com

On 08/29/2013 02:27 AM, HATAYAMA Daisuke wrote:
> This is the patch series to address the issue that kdump 2nd kernel
> now fails to wake up multiple CPUs.

Please explain the "now" in the above sentence.  Is this a regression?
If so, what is its impact?  Is this something that needs to go into 3.11
as a post-rc7 change, which means it better be hyper-critical?

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
