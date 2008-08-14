Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KTcxq-0006ii-NG
	for kexec@lists.infradead.org; Thu, 14 Aug 2008 13:34:07 +0000
Date: Thu, 14 Aug 2008 09:34:03 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Kdump Automation Mechanism
Message-ID: <20080814133403.GA4157@redhat.com>
References: <249026.52731.qm@web1110.biz.mail.sk1.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <249026.52731.qm@web1110.biz.mail.sk1.yahoo.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Cai Qian <caiqian@cclom.cn>
Cc: kexec@lists.infradead.org

On Thu, Aug 14, 2008 at 01:03:48AM -0700, Cai Qian wrote:
> Hi,
> 
> I am wondering if this is the right project to accept Kdump automation files. For example, Kdump
> daemon init script, mkdumprd (read from Kdump configuration file and generate Kdump initramfs for
> the system), default Kdump configuration file, tools to compress vmcore etc.
> 
> The problem I am having right now is that, I am trying to write a Kdump test suite, but I could
> not 
> find a easy way to write a general enough suite for every distro to use. Red Hat and SUSE have
> slightly different setting up. Debian and Ubuntu don't have Kdump automation mechanism as the time
> I was checking. Also, It make things much easier for different distros and users to pick it up and
> contribute to those efforts.
> 

Couln't agree more. Distributions tend to diverge when it comes to user
space implementation of things and that makes testing and community
contribution very difficult (Apart from normal user being confused).

We need to put some effort in making sure we diverge as less as possible.
How to do that? I can think of two things.

- Development of user space utilities/applications takes place while
  interacting with community. For example, filtering utility, makedumpfile
  development took place while taking feedback from community on kexec
  mailing list.

- Willingness on the user space developers to come to a common platform
  and put a concious effort to keep things similar.  (Of course good
  things similar).

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
