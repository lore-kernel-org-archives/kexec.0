Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W3UFP-0006S1-3O
 for kexec@lists.infradead.org; Wed, 15 Jan 2014 17:27:23 +0000
Message-ID: <52D6C4B6.8010804@zytor.com>
Date: Wed, 15 Jan 2014 09:26:14 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [RESEND PATCH v10] x86, apic, kexec,
 Documentation: Add disable_cpu_apicid kernel parameter
References: <20140115064458.1545.38775.stgit@localhost6.localdomain6>
 <20140115170525.GF3180@redhat.com>
In-Reply-To: <20140115170525.GF3180@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: fengguang.wu@intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, jingbai.ma@hp.com

On 01/15/2014 09:05 AM, Vivek Goyal wrote:
> 
> I think this is a reasonable approach to solve the issue. Use a command
> line to not bring up specific cpu in second kernel which can create
> problems.
> 
> Acked-by: Vivek Goyal <vgoyal@redhat.com>
> 
> hpa, I know you are not excited about this approach. If you made up your
> mind that this appoarch is not worth pursuing, please do suggest what
> would you like to see and we can give that a try.
> 
> We want to solve this problem as on large memory machines saving dump can
> take lot of time and we want to bring up multiple cpus and speed up
> compression and save on dump time.
> 

I'm not excited about kdump's reliance on the command line, since it
seems to be a neverending source of trouble, simply because the command
line is fundamentally intended as a human interface.  However, this
seems relatively harmless in comparison with everything else and I am
much happier with saving the ID in the first kernel rather than trying
to guess if a currently-downed CPU is the BSP.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
