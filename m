Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cavan.codon.org.uk ([2a00:1098:0:80:1000:c:0:1])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VllBs-0000J6-Ne
 for kexec@lists.infradead.org; Wed, 27 Nov 2013 19:54:29 +0000
Date: Wed, 27 Nov 2013 19:53:17 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] PCI: Clear Bus Master bit only on kexec reboot
Message-ID: <20131127195317.GA13028@srcf.ucam.org>
References: <1385579908-24608-1-git-send-email-khalid.aziz@oracle.com>
 <20131127192420.GC11829@srcf.ucam.org>
 <52964C9A.6040305@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52964C9A.6040305@oracle.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: cl91tp@gmail.com, gnomes@lxorguk.ukuu.org.uk, indou.takao@jp.fujitsu.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, f.otti@gmx.at, khlebnikov@openvz.org, ebiederm@xmission.com, jility09@gmail.com, bhelgaas@google.com, tianyu.lan@intel.com

On Wed, Nov 27, 2013 at 12:48:42PM -0700, Khalid Aziz wrote:

> I debated between pci.h and kexec.h but pci-driver.c does not
> include kexec.h and I didn't want to include a whole new file. Now I
> see another problem with adding that extern declaration to pci.h -
> if CONFIG_KEXEC is not set, build will fail. I should add #ifdef
> CONFIG_KEXEC to the code in pci-driver.c as well. Time for v2.

You're making the behaviour of the pci code conditional on whether we're 
in kexec or not, so I think adding kexec.h is perfectly reasonable.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
