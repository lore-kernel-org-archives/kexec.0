Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.171.29] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JbigD-0000G4-Gi
	for kexec@lists.infradead.org; Tue, 18 Mar 2008 20:45:11 +0000
Message-ID: <47E029E3.4050101@sgi.com>
Date: Tue, 18 Mar 2008 13:45:23 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: Re: force a dump on a hung system?
References: <47DFFB45.3060106@sgi.com> <frovcv$lss$1@ger.gmane.org>
	<47E01E6E.2090809@redhat.com>
In-Reply-To: <47E01E6E.2090809@redhat.com>
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
To: Ben Woodard <woodard@redhat.com>
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org

Ben Woodard wrote:
> does it have a BMC can you use IPMI to trigger an NMI?

We do have a BMC that comes from the vendor. I checked
with our CMC guy and it seemed there was no way to trigger
an NMI through IPMI, or to send the Magic SYSRQ sequence via
the IMPI SOL serious console.

BTW, the SYSRQ_ENABLED in /etc/sysconfig/sysctl is not set
by default. Any bad side effect of setting it?

- jay

> 
> -ben
> 
> 
> Bernhard Walle wrote:
>> * Jay Lan [2008-03-18 18:26]:
>>
>>   
>>> How do i force a dump on a hung system when
>>> 1) it does not respond to the serial console, and
>>>     
>> Also not sysrq? Attach a PS/2 keyboard and sysrq?
>>
>>   
>>> Am i out of luck?
>>>     
>> Looks like you are. :(
>>
>>
>>         Bernhard
>>
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>   
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
