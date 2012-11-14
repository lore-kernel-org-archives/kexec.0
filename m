Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TYj0J-00076v-1L
 for kexec@lists.infradead.org; Wed, 14 Nov 2012 19:52:08 +0000
Date: Wed, 14 Nov 2012 14:52:00 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <935158332.31770683.1352922720179.JavaMail.root@redhat.com>
In-Reply-To: <20121113161000.GA2942@host-192-168-1-59.local.net-space.pl>
Subject: Re: [PATCH 0/5] crash: Bundle of fixes for Xen
MIME-Version: 1.0
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: olaf@aepfle.de, xen-devel@lists.xensource.com, konrad wilk <konrad.wilk@oracle.com>, andrew cooper3 <andrew.cooper3@citrix.com>, ptesarik@suse.cz, duanshuidao@hotmail.com, jbeulich@suse.com, kexec@lists.infradead.org, crash-utility@redhat.com



----- Original Message -----
> Hi,
> 
> Here is next bundle of fixes for crash Xen support:
>   - xen: Fix page tables caching issues,
>   - xen: Use init_tss array or per_cpu__init_tss,
>   - xen: Use per_cpu__crash_notes or crash_notes array,
>   - xen: Try hard to get max_cpus value,
>   - xen: Use cpu_present_map instead of cpu_online_map.
> 
> All patches were tested with Xen versions up to 4.2.
> 
> Daniel
> 

Hi Daniel,

The patches look reasonable to me, and they test OK on older
RHEL5 dom0 dumpfiles.  It would be interesting to see whether
they work for Hu Jun's SUSE kernel dumpfile.  I've cc'd him
directly.

Thanks,
  Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
