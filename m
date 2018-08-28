Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 28 Aug 2018 21:43:47 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v13 03/16] s390, kexec_file: drop arch_kexec_mem_walk()
Message-ID: <20180828134347.GB12178@dhcp-128-65.nay.redhat.com>
References: <20180801075820.3753-1-takahiro.akashi@linaro.org>
 <20180801075820.3753-4-takahiro.akashi@linaro.org>
 <20180801102951.527cfc57@ThinkPad>
 <20180802000150.GN11258@linaro.org>
 <20180806055047.GC4246@dhcp-128-65.nay.redhat.com>
 <20180809033416.GA5069@dhcp-128-65.nay.redhat.com>
 <1235507889.17337085.1533788045597.JavaMail.zimbra@redhat.com>
 <20180828052107.GE12252@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180828052107.GE12252@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, Pingfan Liu <piliu@redhat.com>, Philipp Rudo <prudo@linux.ibm.com>, catalin marinas <catalin.marinas@arm.com>, will deacon <will.deacon@arm.com>, dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com, heiko carstens <heiko.carstens@de.ibm.com>, ard biesheuvel <ard.biesheuvel@linaro.org>, james morse <james.morse@arm.com>, bhsharma@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, "piliu@redhat.com Thiago Jung Bauermann" <bauerman@linux.vnet.ibm.com>

Hi AKASHI,
On 08/28/18 at 02:21pm, AKASHI Takahiro wrote:
> Hi Dave,
> 
> On Thu, Aug 09, 2018 at 12:14:05AM -0400, Pingfan Liu wrote:
> > 
> > 
> > 
> > 
> > ----- Original Message -----
> > > From: "Dave Young" <dyoung@redhat.com>
> > > To: "AKASHI Takahiro" <takahiro.akashi@linaro.org>, "Philipp Rudo" <prudo@linux.ibm.com>, "catalin marinas"
> > > <catalin.marinas@arm.com>, "will deacon" <will.deacon@arm.com>, dhowells@redhat.com, vgoyal@redhat.com,
> > > herbert@gondor.apana.org.au, davem@davemloft.net, bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com, "heiko
> > > carstens" <heiko.carstens@de.ibm.com>, "ard biesheuvel" <ard.biesheuvel@linaro.org>, "james morse"
> > > <james.morse@arm.com>, bhsharma@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
> > > linux-kernel@vger.kernel.org, "piliu@redhat.com Thiago Jung Bauermann" <bauerman@linux.vnet.ibm.com>
> > > Sent: Thursday, August 9, 2018 11:34:16 AM
> > > Subject: Re: [PATCH v13 03/16] s390, kexec_file: drop arch_kexec_mem_walk()
> > > 
> > > Add more cc. Pingfan Liu confirmed ppc does not use 0 as valid address,
> > > if so it should be safe.
> > > 
> > > Pingfan, can you add more words?
> > > 
> > 
> > ppc64 uses a few KB starting from 0 for exception handler.
> 
> It assures that 0 (zero) is valid, but won't be assigned as a result of
> kexec_add_buffer().
> 
> So do you think that yet I should submit another patch set, introducing
> explicit KEXEC_BUF_MEM_UNKNOWN, while assuming 0 by default is safe for now?
> 
> Now that this is the only comment against my v13, it's up to you.

I'm fine with your proposal.  It is simple enough, and we can look into
it when it becomes a problem in the future which is unlikely.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
