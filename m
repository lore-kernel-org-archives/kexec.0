Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TUOtK-00071K-NV
 for kexec@lists.infradead.org; Fri, 02 Nov 2012 21:35:03 +0000
Message-ID: <50943C5A.9050106@zytor.com>
Date: Fri, 02 Nov 2012 14:34:18 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: Kdump with signed images
References: <20121025185520.GA17995@redhat.com>
 <1351214158.18115.186.camel@falcor> <20121026023916.GA16762@srcf.ucam.org>
 <20121026170609.GB24687@redhat.com> <1351276649.18115.217.camel@falcor>
 <20121101131003.GA14573@redhat.com> <20121101135356.GA15659@redhat.com>
 <1351780159.15708.17.camel@falcor> <20121101144304.GA15821@redhat.com>
 <20121101145225.GB10269@srcf.ucam.org> <20121102132318.GA3300@redhat.com>
 <CAKTCnzkQwhWGJRTiuxv8wp7uPDFoT6eGsN0k51Bvw8=EqQFW=w@mail.gmail.com>
In-Reply-To: <CAKTCnzkQwhWGJRTiuxv8wp7uPDFoT6eGsN0k51Bvw8=EqQFW=w@mail.gmail.com>
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
To: Balbir Singh <bsingharora@gmail.com>
Cc: Roberto Sassu <roberto.sassu@polito.it>, Dmitry Kasatkin <dmitry.kasatkin@intel.com>, Kees Cook <keescook@chromium.org>, Peter Jones <pjones@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux kernel mailing list <linux-kernel@vger.kernel.org>, horms@verge.net.au, "Eric W. Biederman" <ebiederm@xmission.com>, Matthew Garrett <mjg@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, Khalid Aziz <khalid@gonehiking.org>

On 11/02/2012 07:29 AM, Balbir Singh wrote:
> 
> Have you seen http://sourceware.org/glibc/wiki/FAQ - "Even statically
> linked programs need some shared libraries which is not acceptable for
> me. What can I do?" Probably, worth trying.
> 

You can build something with klibc... a static klibc binary can easily
be smaller than a dynamic glibc binary.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
