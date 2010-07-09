Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OXDg5-0007Bj-7t
	for kexec@lists.infradead.org; Fri, 09 Jul 2010 13:31:41 +0000
Date: Fri, 9 Jul 2010 09:31:38 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Kdump and kexec
Message-ID: <20100709133138.GB3672@redhat.com>
References: <E27739FC41FADC49A98999F21AC13A4303EAB58A80@CHNINMSMBX01.chennaiodc.lntinfotech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E27739FC41FADC49A98999F21AC13A4303EAB58A80@CHNINMSMBX01.chennaiodc.lntinfotech.com>
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
To: Dinesh Thanumoorthy <Dinesh.Thanumoorthy@lntinfotech.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

On Fri, Jul 09, 2010 at 10:35:07AM +0530, Dinesh Thanumoorthy wrote:
> Hi,
> 
>      Problem :
> 
> 
> 
>                     I am using KVM-88 modules  with 2.6.21 public kernel.
> 
>  I simulate a crash and load new kernel with kexec is fine. But after inserting kvm modules ,It is hanging .
> 

CCing to kexec mailig list. 

IIRC, there were issues with kvm + kexec as kvm was doing something
special. Try newer/latest kernels and i think it should work.

Thanks
Vivek


> 
> 
> 
>  Could u please suggest some ideas to resolve the problem
> 
> 
> Reg
> Dinesh.T
> 
> ________________________________
> This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.
> 
> ______________________________________________________________________

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
