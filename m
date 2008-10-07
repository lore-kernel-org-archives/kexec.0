Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KnCXn-0003gZ-12
	for kexec@lists.infradead.org; Tue, 07 Oct 2008 13:24:07 +0000
Date: Tue, 7 Oct 2008 09:24:01 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kdump: quad core Opteron
Message-ID: <20081007132401.GA4007@redhat.com>
References: <48EB5B68.8010401@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48EB5B68.8010401@in.ibm.com>
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
To: Chandru <chandru@in.ibm.com>
Cc: kexec@lists.infradead.org

On Tue, Oct 07, 2008 at 06:21:52PM +0530, Chandru wrote:
> kdump on a quad core Opteron blade machine doesn't give a complete  
> vmcore on the system.   All works well until we attempt to copy  
> /proc/vmcore to some target place ( disk , n/w ). The system immediately  
> resets without any OS messages after having copied few mb's of vmcore  
> file.  Problem also occurs with 2.6.27-rc8 and latest kexec-tools.  If  
> we pass 'mem=4G' as boot parameter to the first kernel, then kdump  
> succeeds in copying a readable vmcore to /var/crash.
>

Hi Chandru,

How much memory this system has got. Can you also paste the output of 
/proc/iomem of first kernel.

Does this system has GART? So looks like we are accessing some memory area
which platform does not like. (We saw issues with GART in the past.)

Can you also provide /proc/vmcore ELF header (readelf output), in both
the cases (mem=4G and without that).

You can try putting some printk in /proc/vmcore code and see which
physical memory area you are accessing when system goes bust. If in all
the failure cases it is same physical memory area, then we can try to find
what's so special about it.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
