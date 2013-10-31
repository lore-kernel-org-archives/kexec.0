Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VbsIb-0008UA-Vo
 for kexec@lists.infradead.org; Thu, 31 Oct 2013 13:28:34 +0000
Date: Thu, 31 Oct 2013 09:27:45 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 0/3] x86, apic, kexec: Add disable_cpu_apic kernel
 parameter
Message-ID: <20131031132744.GB3392@redhat.com>
References: <20131022150015.24240.39686.stgit@localhost6.localdomain6>
 <20131022220803.GA32387@anatevka.fc.hp.com>
 <526712B2.7070108@jp.fujitsu.com>
 <20131031005812.GA15459@anatevka.fc.hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131031005812.GA15459@anatevka.fc.hp.com>
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
To: jerry.hoemann@hp.com
Cc: fengguang.wu@intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, bp@alien8.de, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, jingbai.ma@hp.com

On Wed, Oct 30, 2013 at 06:58:13PM -0600, jerry.hoemann@hp.com wrote:

[..]
> Daisuke,
> 
> Are you planning on making changes to the kexec tools to automate
> the setting of disable_cpu_apic to the capture kernel? Or do you
> know someone who is planning this?

I think we should not make this change in kexec-tools and should leave
it to distro scripts to append disable_cpu_apic.

Who knows in future this restriction is not there at all and kexec-tools
will be stuck with always passing disable_cpu_apic. Getting rid of
this parameter in distro scripts will be much easier.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
