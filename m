Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T9zbq-0003bO-No
 for kexec@lists.infradead.org; Fri, 07 Sep 2012 14:32:39 +0000
Subject: Re: [PATCH]kdump: pass noefi and acpi_rsdp= to 2nd kernel
From: Khalid Aziz <khalid.aziz@hp.com>
In-Reply-To: <20120906202406.GD27209@redhat.com>
References: <20120905054445.GA6370@dhcp-16-143.nay.redhat.com>
 <5047DBA9.8030000@hp.com>  <20120906202406.GD27209@redhat.com>
Date: Fri, 07 Sep 2012 08:32:33 -0600
Message-ID: <1347028353.20255.75.camel@lyra>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: dyoung@redhat.com, horms@verge.net.au, kexec@lists.infradead.org

On Thu, 2012-09-06 at 16:24 -0400, Vivek Goyal wrote:
> On Wed, Sep 05, 2012 at 05:09:29PM -0600, Khalid Aziz wrote:
> [..]
> > More work will be needed to make this work, for example pass the
> > EFI runtime service memory map from one kernel to the next so we
> > keep it mapped in exact same spot, and other similar mapping issues.
> 
> Hi Khalid,
> 
> This sounds like significant amount of work. So till this work really
> gets merged, noefi is not a bad option. Atleast it will allow us
> to capture dump. And once a generic fix is in, one can remove it and
> build more fancy features which make use of EFI services in second
> kernel?

Hi Vivek,

You are right, it indeed is significant amount of work. I agree noefi is
a reasonable option until EFI is fully working with kexec. As long as
noefi is not seen as long term solution, it makes perfect sense.

Thanks
-- 
Khalid Aziz <khalid.aziz@hp.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
