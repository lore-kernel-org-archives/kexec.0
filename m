Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.al2klimov.de ([2a01:4f8:c0c:1465::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqgbe-00012k-NW
 for kexec@lists.infradead.org; Wed, 01 Jul 2020 17:33:11 +0000
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: kdump
References: <20200627103151.71942-1-grandmaster@al2klimov.de>
 <20200701075803.GB3878@dhcp-128-65.nay.redhat.com>
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <1de76ef5-e447-2274-c45a-3b0356bd63ae@al2klimov.de>
Date: Wed, 1 Jul 2020 19:33:04 +0200
MIME-Version: 1.0
In-Reply-To: <20200701075803.GB3878@dhcp-128-65.nay.redhat.com>
Content-Language: en-US
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: bhe@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com



Am 01.07.20 um 09:58 schrieb Dave Young:
> On 06/27/20 at 12:31pm, Alexander A. Klimov wrote:
>> Rationale:
>> Reduces attack surface on kernel devs opening the links for MITM
>> as HTTPS traffic is much harder to manipulate.
>>
>> Deterministic algorithm:
>> For each file:
>>    If not .svg:
>>      For each line:
>>        If doesn't contain `\bxmlns\b`:
>>          For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>>            If both the HTTP and HTTPS versions
>>            return 200 OK and serve the same content:
>>              Replace HTTP with HTTPS.
>>
>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
>> ---
>>   If there are any URLs to be removed completely or at least not HTTPSified:
>>   Just clearly say so and I'll *undo my change*.
>>   See also https://lkml.org/lkml/2020/6/27/64
>>
>>   If there are any valid, but yet not changed URLs:
>>   See https://lkml.org/lkml/2020/6/26/837
>>
>>   Documentation/admin-guide/kdump/kdump.rst | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
>> index 2da65fef2a1c..8cfa35f777f5 100644
>> --- a/Documentation/admin-guide/kdump/kdump.rst
>> +++ b/Documentation/admin-guide/kdump/kdump.rst
>> @@ -65,20 +65,20 @@ Install kexec-tools
>>   
>>   2) Download the kexec-tools user-space package from the following URL:
>>   
>> -http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools.tar.gz
>> +https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools.tar.gz
>>   
>>   This is a symlink to the latest version.
>>   
>>   The latest kexec-tools git tree is available at:
>>   
>>   - git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
>> -- http://www.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
>> +- https://www.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
>>   
>>   There is also a gitweb interface available at
>> -http://www.kernel.org/git/?p=utils/kernel/kexec/kexec-tools.git
>> +https://www.kernel.org/git/?p=utils/kernel/kexec/kexec-tools.git
>>   
>>   More information about kexec-tools can be found at
>> -http://horms.net/projects/kexec/
>> +https://horms.net/projects/kexec/
>>   
>>   3) Unpack the tarball with the tar command, as follows::
>>   
>> @@ -511,7 +511,7 @@ dump kernel.
>>   You can also use the Crash utility to analyze dump files in Kdump
>>   format. Crash is available on Dave Anderson's site at the following URL:
>>   
>> -   http://people.redhat.com/~anderson/
>> +   https://people.redhat.com/~anderson/
> 
> Would you mind to update above url as well?
I'll update all of the URLs not changed yet, but (please) not in this 
patch round.

See also https://lkml.org/lkml/2020/6/26/837

> 
> Dave have moved it to below url instead:
> https://crash-utility.github.io/
> 
> Thanks
> Dave
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
