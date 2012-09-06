Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T9icW-000455-6n
 for kexec@lists.infradead.org; Thu, 06 Sep 2012 20:24:13 +0000
Date: Thu, 6 Sep 2012 16:24:06 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH]kdump: pass noefi and acpi_rsdp= to 2nd kernel
Message-ID: <20120906202406.GD27209@redhat.com>
References: <20120905054445.GA6370@dhcp-16-143.nay.redhat.com>
 <5047DBA9.8030000@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5047DBA9.8030000@hp.com>
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
To: Khalid Aziz <khalid.aziz@hp.com>
Cc: dyoung@redhat.com, horms@verge.net.au, kexec@lists.infradead.org

On Wed, Sep 05, 2012 at 05:09:29PM -0600, Khalid Aziz wrote:
[..]
> More work will be needed to make this work, for example pass the
> EFI runtime service memory map from one kernel to the next so we
> keep it mapped in exact same spot, and other similar mapping issues.

Hi Khalid,

This sounds like significant amount of work. So till this work really
gets merged, noefi is not a bad option. Atleast it will allow us
to capture dump. And once a generic fix is in, one can remove it and
build more fancy features which make use of EFI services in second
kernel?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
