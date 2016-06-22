Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bFiIs-0003v9-J9
 for kexec@lists.infradead.org; Wed, 22 Jun 2016 13:34:53 +0000
Received: by mail-pf0-x243.google.com with SMTP id t190so4118943pfb.2
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 06:34:29 -0700 (PDT)
Date: Wed, 22 Jun 2016 23:29:46 +1000
From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v3 0/9] kexec_file_load implementation for PowerPC
Message-ID: <20160622232946.793d6c04@350D>
In-Reply-To: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

On Tue, 21 Jun 2016 16:48:32 -0300
Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> wrote:

> Hello,
> 
> This patch series implements the kexec_file_load system call on
> PowerPC.
> 
> This system call moves the reading of the kernel, initrd and the
> device tree from the userspace kexec tool to the kernel. This is
> needed if you want to do one or both of the following:
> 
> 1. only allow loading of signed kernels.
> 2. "measure" (i.e., record the hashes of) the kernel, initrd, kernel
>    command line and other boot inputs for the Integrity Measurement
>    Architecture subsystem.
> 
> The above are the functions kexec already has built into
> kexec_file_load. Yesterday I posted a set of patches which allows a
> third feature:
> 
> 3. have IMA pass-on its event log (where integrity measurements are
>    registered) accross kexec to the second kernel, so that the event
>    history is preserved.

OK.. and this is safe? Do both the kernels need to be signed by the
same certificate?


Balbir Singh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
