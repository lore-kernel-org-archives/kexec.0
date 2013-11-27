Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vll6s-00009v-JO
 for kexec@lists.infradead.org; Wed, 27 Nov 2013 19:49:19 +0000
Message-ID: <52964C9A.6040305@oracle.com>
Date: Wed, 27 Nov 2013 12:48:42 -0700
From: Khalid Aziz <khalid.aziz@oracle.com>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: Clear Bus Master bit only on kexec reboot
References: <1385579908-24608-1-git-send-email-khalid.aziz@oracle.com>
 <20131127192420.GC11829@srcf.ucam.org>
In-Reply-To: <20131127192420.GC11829@srcf.ucam.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: cl91tp@gmail.com, gnomes@lxorguk.ukuu.org.uk, indou.takao@jp.fujitsu.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, f.otti@gmx.at, khlebnikov@openvz.org, ebiederm@xmission.com, jility09@gmail.com, bhelgaas@google.com, tianyu.lan@intel.com

On 11/27/2013 12:24 PM, Matthew Garrett wrote:
> On Wed, Nov 27, 2013 at 12:18:28PM -0700, Khalid Aziz wrote:
>
>> +/* flag to track if kexec reboot is in progress */
>> +extern unsigned long kexec_in_progress;
>
> Adding this to pci.h seems a little odd. We may want to use it somewhere
> else at some point. Add it to kexec.h instead?
>

I debated between pci.h and kexec.h but pci-driver.c does not include 
kexec.h and I didn't want to include a whole new file. Now I see another 
problem with adding that extern declaration to pci.h - if CONFIG_KEXEC 
is not set, build will fail. I should add #ifdef CONFIG_KEXEC to the 
code in pci-driver.c as well. Time for v2.

--
Khalid

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
