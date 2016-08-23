Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bc2Ha-0003uN-1n
 for kexec@lists.infradead.org; Tue, 23 Aug 2016 03:21:46 +0000
Received: by mail-pf0-x241.google.com with SMTP id i6so7413361pfe.0
 for <kexec@lists.infradead.org>; Mon, 22 Aug 2016 20:21:25 -0700 (PDT)
Subject: Re: [PATCH v5 04/13] powerpc: Factor out relocation code from
 module_64.c to elf_util_64.c.
References: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <4126991.2tm6WB17SD@hactar> <3ca4a2de-0d44-dbc6-b57b-c149d10b048f@gmail.com>
 <4586138.sszncvQpYx@hactar>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <239172a5-1952-de2d-e48d-4ca7d882356c@gmail.com>
Date: Tue, 23 Aug 2016 13:21:04 +1000
MIME-Version: 1.0
In-Reply-To: <4586138.sszncvQpYx@hactar>
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
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Young <dyoung@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Oliver O'Halloran <oohall@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>


> zImage on ppc64 BE is an ELF32 file. This patch set only supports loading 
> ELF files of the same class as the kernel, so a 64 bit kernel can't load an 
> ELF32 file. It would be possible to add such support, but it would be a new 
> feature.
> 
> The distros I was able to check on ppc64 LE and BE all use vmlinux.
> kexec-tools with kexec_load also doesn't support zImage. Do you think it is 
> important to support zImage?
> 

Well if it didn't work already, I think its low priority. Michael should be
able to confirm this. Oliver's been trying to cleanup the zImage to get rid
the old zImage limitation, cc'ing him

Balbir Singh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
