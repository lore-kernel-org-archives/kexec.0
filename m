From: Jay Lan <jlan@sgi.com>
Date: Wed, 20 Aug 2008 13:07:53 -0700
Subject: Kdump Automation Mechanism
In-Reply-To: <536253.14632.qm@web1114.biz.mail.sk1.yahoo.com>
References: <536253.14632.qm@web1114.biz.mail.sk1.yahoo.com>
Message-ID: <48AC7999.2020104@sgi.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Cai Qian wrote:
> Hi Bernhard and Neil,
> 
> --- Bernhard Walle <bwalle@suse.de> wrote:
> 
>> * Jay Lan [2008-08-14 10:23]:
>>> If you can put vmcore at the same location... Ahh, asking too much? ;)
>> Will change that to /var/crash since that's FHS 2.3 anyway. :)
>> [And I personally never liked ???/var/log/dump??? since it's not a logfile.]
>>
> 
> That's a good. Do you have any consideration for standard Kdump options? I have created a Kdump
> test suite but it originally written and tested on RHEL and Fedora.
> 
> http://sourceforge.net/mailarchive/message.php?msg_name=20080815.210735.450985660335275199.qcai%40redhat.com

Hi Cai,

I clicked on the attachment of the page above, it failed with:
   File not found on server.

Regards,
 - jay

> 
> I hope it could also work for SLES, OpenSUSE and other distros. However, I have no environment to
> test it yet, and I found it is kind of difficult to port it to other distros for so many different
> options.
> 
> I'd appreciate if you guys could have a look, and come out a standard Kdump options. I'd also be
> happy to modify the suite accordingly.
> 
> Thanks,
> CaiQian
> 
>>
>> Bernhard
>> -- 
>> Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development
>>
>> ???Make everything as simple as possible, but not simpler.???
>>        -- Albert Einstein
>>
>> _______________________________________________
>> kexec mailing list
>> kexec at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>
> 
> 
> _______________________________________________
> kexec mailing list
> kexec at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


