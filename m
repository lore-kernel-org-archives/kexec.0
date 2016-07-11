Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bMRBi-0002lD-GC
 for kexec@lists.infradead.org; Mon, 11 Jul 2016 02:43:14 +0000
Date: Mon, 11 Jul 2016 10:42:47 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
Message-ID: <20160711024247.GA2853@dhcp-128-65.nay.redhat.com>
References: <1467908615-18952-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1467908615-18952-4-git-send-email-bauerman@linux.vnet.ibm.com>
 <87a8hqja39.fsf@@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a8hqja39.fsf@@concordia.ellerman.id.au>
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
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

On 07/10/16 at 04:11pm, Michael Ellerman wrote:
> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> 
> > kexec_locate_mem_hole will be used by the PowerPC kexec_file_load
> > implementation to find free memory for the purgatory stack.
> >
> > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: Dave Young <dyoung@redhat.com>
> 
> Dave are you happy with the first three patches? If so do you mind
> sending an ack?

I reviewed the 3 patches, they look good to me. Will ack after a small test today.

> 
> Given the series touches generic code, x86 and powerpc this might be one
> for Andrew to take. Or is there a kexec tree it should go through?

They should go Andrew's tree, but I'm not sure about the powerpc part.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
