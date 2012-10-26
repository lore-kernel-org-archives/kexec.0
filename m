Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cavan.codon.org.uk ([93.93.128.6])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TRoVJ-00071t-Tx
 for kexec@lists.infradead.org; Fri, 26 Oct 2012 18:19:35 +0000
Date: Fri, 26 Oct 2012 19:19:05 +0100
From: Matthew Garrett <mjg@redhat.com>
Subject: Re: Kdump with signed images
Message-ID: <20121026181904.GA5770@srcf.ucam.org>
References: <20121023145920.GD16496@redhat.com>
 <87fw552mb4.fsf_-_@xmission.com> <20121024173651.GE1821@redhat.com>
 <1351145401.18115.78.camel@falcor>
 <20121025141048.GD9377@redhat.com>
 <1351190421.18115.92.camel@falcor>
 <20121025185520.GA17995@redhat.com>
 <1351214158.18115.186.camel@falcor>
 <20121026023916.GA16762@srcf.ucam.org>
 <1351274374.18115.205.camel@falcor>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1351274374.18115.205.camel@falcor>
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@intel.com>, Kees Cook <keescook@chromium.org>, kexec@lists.infradead.org, linux kernel mailing list <linux-kernel@vger.kernel.org>, horms@verge.net.au, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Roberto Sassu <roberto.sassu@polito.it>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Khalid Aziz <khalid@gonehiking.org>

On Fri, Oct 26, 2012 at 01:59:34PM -0400, Mimi Zohar wrote:
> On Fri, 2012-10-26 at 03:39 +0100, Matthew Garrett wrote:
> > and it must be impossible for anything other than 
> > /sbin/kexec to make the kexec system call.
> 
> Permission is a MAC issue. :)

It's a MAC issue that has to be implemented in the kernel. We can't 
depend on userspace loading any kind of policy.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
