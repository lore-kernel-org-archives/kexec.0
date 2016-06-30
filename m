Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bIf3I-0007kl-Sc
 for kexec@lists.infradead.org; Thu, 30 Jun 2016 16:42:57 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5UGflEh128998
 for <kexec@lists.infradead.org>; Thu, 30 Jun 2016 12:42:35 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23v6yetwv7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 30 Jun 2016 12:42:34 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 30 Jun 2016 13:42:30 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 33D8C1DC0080
 for <kexec@lists.infradead.org>; Thu, 30 Jun 2016 12:42:20 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5UGgRJL4890826
 for <kexec@lists.infradead.org>; Thu, 30 Jun 2016 13:42:27 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5UGgRUh014837
 for <kexec@lists.infradead.org>; Thu, 30 Jun 2016 13:42:27 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/9] kexec_file: Generalize kexec_add_buffer.
Date: Thu, 30 Jun 2016 13:42:25 -0300
In-Reply-To: <1866019.1p7Z0CLUZh@hactar>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160630150700.GA3058@dhcp-128-65.nay.redhat.com>
 <1866019.1p7Z0CLUZh@hactar>
MIME-Version: 1.0
Message-Id: <1902156.s2yTykCR7c@hactar>
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
To: Dave Young <dyoung@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

Am Donnerstag, 30 Juni 2016, 12:49:44 schrieb Thiago Jung Bauermann:
> Am Donnerstag, 30 Juni 2016, 11:07:00 schrieb Dave Young:
> > On 06/29/16 at 06:18pm, Thiago Jung Bauermann wrote:
> > > I'm not following. The IMA buffer patchset doesn't use
> > > kexec_locate_mem_hole nor struct kexec_buf.
> > 
> > It does not use kexec_locate_mem_hole, but the buffer being passed is
> > very similar to a kexec_buf struct, no?
> 
> If what you're saying is that the arguments passed to
> kexec_add_handover_buffer in the IMA buffer patchset are very similar to
> the arguments passed to kexec_add_buffer then yes, it's true.
> 
> > So you may refactor kexec_add_buffer and your new function to pass only
> > kimage and a kbuf, it will be better than passing all those arguments
> > separately.
> 
> To be honest I think struct kexec_buf is an implementation detail inside
> kexec_locate_mem_hole, made necessary because the callback functions it
> uses need to access its arguments. Callers of kexec_locate_mem_hole,
> kexec_add_handover_buffer and kexec_add_buffer shouldn't need to know it
> exists.

Elaborating a bit more: the argument list for these three functions are 
equal or similar because kexec_add_handover_buffer uses kexec_add_buffer, 
which uses kexec_locate_mem_hole.

It could be beneficial to have a struct to collect the arguments to these 
functions if someone using one of them would be likely to use another one 
with the same arguments. In that case, you set up kexec_buf once and then 
just pass it whenever you need to call one of those functions.

But that is unlikely to happen. A user of the kexec API will need to use 
only one of these functions with a given set of arguments, so they don't 
gain anything by setting up a struct.

Syntactically, I also don't think it's clearer to set struct members instead 
of simply passing arguments to a function, even if the argument list is 
long.

[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
