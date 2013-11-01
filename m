Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vc2ef-0005os-SH
 for kexec@lists.infradead.org; Fri, 01 Nov 2013 00:32:02 +0000
Date: Fri, 1 Nov 2013 09:31:33 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4 0/3] x86, apic, kexec: Add disable_cpu_apic kernel
 parameter
Message-ID: <20131101003133.GH6818@verge.net.au>
References: <20131022150015.24240.39686.stgit@localhost6.localdomain6>
 <20131022220803.GA32387@anatevka.fc.hp.com>
 <526712B2.7070108@jp.fujitsu.com>
 <20131031005812.GA15459@anatevka.fc.hp.com>
 <20131031132744.GB3392@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131031132744.GB3392@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: hpa@linux.intel.com, kexec@lists.infradead.org, jerry.hoemann@hp.com, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, bp@alien8.de, ebiederm@xmission.com, akpm@linux-foundation.org, fengguang.wu@intel.com, jingbai.ma@hp.com

On Thu, Oct 31, 2013 at 09:27:45AM -0400, Vivek Goyal wrote:
> On Wed, Oct 30, 2013 at 06:58:13PM -0600, jerry.hoemann@hp.com wrote:
> 
> [..]
> > Daisuke,
> > 
> > Are you planning on making changes to the kexec tools to automate
> > the setting of disable_cpu_apic to the capture kernel? Or do you
> > know someone who is planning this?
> 
> I think we should not make this change in kexec-tools and should leave
> it to distro scripts to append disable_cpu_apic.
> 
> Who knows in future this restriction is not there at all and kexec-tools
> will be stuck with always passing disable_cpu_apic. Getting rid of
> this parameter in distro scripts will be much easier.

Hi Vivek, Hi Daisuke,

That approach sounds reasonable to me.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
