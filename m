Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Q7lxN-0005rp-H4
	for kexec@lists.infradead.org; Thu, 07 Apr 2011 09:56:54 +0000
Date: Thu, 7 Apr 2011 11:56:47 +0200
From: Olaf Hering <olaf@aepfle.de>
Subject: dynamic oldmem in kdump kernel
Message-ID: <20110407095646.GA30788@aepfle.de>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org


Recently kdump for pv-on-hvm Xen guests was implemented by me.

One issue remains:
The xen_balloon driver in the guest frees guest pages and gives them
back to the hypervisor. These pages are marked as mmio in the
hypervisor. During a read of such a page via the /proc/vmcore interface
the hypervisor calls the qemu-dm process. qemu-dm tries to map the page,
this attempt fails because the page is not backed by ram and 0xff is
returned. All this generates high load in dom0 because the reads come
as 8byte requests.

There seems to be no way to make the crash kernel aware of the state of
individual pages in the crashed kernel, it is not aware of memory
ballooning. And doing that from within the "kernel to crash" seems error
prone. Since over time the fragmentation will increase, it would be best
if the crash kernel itself queries the state of oldmem pages. 

If copy_oldmem_page() would call a function, a hook, provided by the Xen
pv-on-hvm drivers to query if the pfn to read from is really backed by
ram the load issue could be avoided. Unfortunately, even Xen needs to
get a new interface to query the state of individual hvm guest pfns for
the purpose mentioned above.



Another issue, slightly related, is memory hotplug.
How is this currently handled for kdump?  Is there code which
automatically reconfigures the kdump kernel with the new memory ranges?


Olaf


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
