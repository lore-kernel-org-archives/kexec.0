Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.246])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KlsNt-0007A0-Ma
	for kexec@lists.infradead.org; Fri, 03 Oct 2008 21:40:26 +0000
Received: by rv-out-0708.google.com with SMTP id b17so2736248rvf.42
	for <kexec@lists.infradead.org>; Fri, 03 Oct 2008 14:40:24 -0700 (PDT)
Message-ID: <86802c440810031440o59359f30ka72230b4b0ff73e@mail.gmail.com>
Date: Fri, 3 Oct 2008 14:40:24 -0700
From: "Yinghai Lu" <yinghai@kernel.org>
Subject: Re: kexec with vmware esx 3.0.2
In-Reply-To: <1223068893.7330.117.camel@bodhitayantram.eng.vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <86802c440810031408i60e2036ax805bfd997092cd86@mail.gmail.com>
	<1223068893.7330.117.camel@bodhitayantram.eng.vmware.com>
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
To: Zachary Amsden <zach@vmware.com>
Cc: Alok Kataria <akataria@vmware.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Oct 3, 2008 at 2:21 PM, Zachary Amsden <zach@vmware.com> wrote:
> On Fri, 2008-10-03 at 14:08 -0700, Yinghai Lu wrote:
>> anyone tried to use linux kernel to kexec vmware esx?
>
> That would not be a recommended practice.  It might work.  It should not
> be very useful.
>

esx 3.0.2 relys on correct mps table,
could boot linux with update_mptable or alloc_mptable, and then load
vmware with kexec.

YH

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
