Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpsOo-0006k8-Ry
 for kexec@lists.infradead.org; Mon, 29 Jun 2020 11:56:35 +0000
Subject: Re: [PATCH 01/11] kexec_file: allow archs to handle special regions
 while locating memory hole
References: <159319825403.16351.7253978047621755765.stgit@hbathini.in.ibm.com>
 <159319828304.16351.6990340111766605842.stgit@hbathini.in.ibm.com>
 <20200629133933.0787f562@ezekiel.suse.cz>
From: Hari Bathini <hbathini@linux.ibm.com>
Message-ID: <7981ae61-26c6-000c-9ee4-382dab3eecab@linux.ibm.com>
Date: Mon, 29 Jun 2020 17:26:23 +0530
MIME-Version: 1.0
In-Reply-To: <20200629133933.0787f562@ezekiel.suse.cz>
Content-Language: en-US
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Petr Tesarik <ptesarik@suse.cz>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>, Pingfan Liu <piliu@redhat.com>, Kexec-ml <kexec@lists.infradead.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>

Hi Petr,

On 29/06/20 5:09 pm, Petr Tesarik wrote:
> Hi Hari,
> 
> is there any good reason to add two more functions with a very similar
> name to an existing function? AFAICS all you need is a way to call a
> PPC64-specific function from within kexec_add_buffer (PATCH 4/11), so
> you could add something like this:
> 
> int __weak arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
> {
> 	return 0;
> }
> 
> Call this function from kexec_add_buffer where appropriate and then
> override it for PPC64 (it roughly corresponds to your
> kexec_locate_mem_hole_ppc64() from PATCH 4/11).
> 
> FWIW it would make it easier for me to follow the resulting code.

Right, Petr.

I was trying out a few things before I ended up with what I sent here.
Bu yeah.. I did realize arch_kexec_locate_mem_hole() would have been better
after sending out v1. Will take care of that in v2.

Thanks
Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
